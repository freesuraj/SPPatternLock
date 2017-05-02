//
//  LockScreen.swift
//  SPPatternLock
//
//  Created by Suraj Pathak on 14/2/17.
//  Copyright © 2017 Suraj. All rights reserved.
//

import UIKit

public class LockScreen: UIView {
    
    private let kSeed   = 23
    private let kAlter1 = 1234
    private let kAlter2 = 4321
    private let kTagId  = 222333
    
    private var selectedCircle: Circle?
    private var patternView: PatternView!
    private var oldCellIndex: Int = -1
    private var currentCellIndex: Int = -1
    private var drawnLines: [Int] = []
    private var finalLines: [Line] = []
    private var cellsInOrder: [Int] = []
    
    private var allowClosedPattern: Bool = true
    
    private var size: Int = 3
    
    private var numberOfCircles: Int {
        return size*size
    }
    
    // Public configurable values
    public struct Config {
        public var lineWidth: CGFloat = 5
        public var lineColor: UIColor = UIColor.white
        public var lineEdgeColor: UIColor = UIColor.white
        public var circleOuterRingColor: UIColor = UIColor.magenta
        public var circleInnerRingColor: UIColor = UIColor.darkGray
        public var circleHighlightColor: UIColor = UIColor.yellow
        
        // Public Initializer for Config
        public init() {}
    }
    
    public var config: Config = Config()
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public typealias PatternHandlerBlock = ((String) -> Void)
    var patternHandler: PatternHandlerBlock?
    
    /**
     Initializes the main lock screen
     
     - parameter frame: `CGRect` where the screen will be drawn
     - parameter size: Size of the lock screen. It will create grids of size X size. Default value is 3
     - parameter allowClosedPattern: If set to `true`, it allows for complicated pattern. Otherwise a circle can't be used twice for a pattern
     - parameter config: Configuration for colors and line width, etc
     - parameter handler: Callback to receive the user pattern
     - returns: Returns the Lock screen
     */
    public convenience init(frame: CGRect, size: Int = 3, allowClosedPattern: Bool = true, config: Config = Config(), handler: PatternHandlerBlock? = nil) {
        self.init(frame: frame)
        self.size = size
        self.allowClosedPattern = allowClosedPattern
        self.config = config
        self.patternHandler = handler
        setNeedsDisplay()
        setupScreen()
        setupGestures()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupScreen() {
        let grid = Double(min(frame.width, frame.height))/Double(2*size+1)
        let gap = grid
        let topOffset = grid
        let radius = grid/2

        for index in 0..<numberOfCircles {
            let circle = Circle(radius: CGFloat(radius))
            circle.outerColor = config.circleOuterRingColor
            circle.innercolor = config.circleInnerRingColor
            circle.highlightColor = config.circleHighlightColor
            circle.lineWidth = config.lineWidth
            
            let row = index/size
            let col = index % size
            let x = (gap + radius) + (gap + 2*radius)*Double(col)
            let y = (Double(row) * gap + Double(row) * 2.0 * radius) + topOffset
            circle.center = CGPoint(x: x, y: y)
            circle.tag = (row+kSeed)*kTagId + (col + kSeed)
            addSubview(circle)
        }
        patternView = PatternView(frame: CGRect(origin: .zero, size: frame.size))
        patternView.lineWidth = config.lineWidth
        patternView.lineColor = config.lineColor
        patternView.linePointColor = config.lineEdgeColor
        
        patternView?.isUserInteractionEnabled = false
        addSubview(patternView)
    }
    
    func setupGestures() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(gestured))
        let tap = UITapGestureRecognizer(target: self, action: #selector(gestured))
        addGestureRecognizer(pan)
        addGestureRecognizer(tap)
    }
    
    func gestured(gesture: UIGestureRecognizer) {
        let point = gesture.location(in: self)
        if gesture is UIPanGestureRecognizer {
            if gesture.state == .ended {
                if finalLines.count > 0 { endPattern() }
                else { resetScreen() }
            } else {
                handlePan(at: point)
            }
        } else {
            let cellPosition = index(point)
            oldCellIndex = currentCellIndex
            if cellPosition >= 0 {
                cellsInOrder.append(currentCellIndex)
                perform(#selector(endPattern), with: nil, afterDelay: 0.3)
            }
        }
    }
    
    /// MARK: Helpers
    
    func endPattern() {
        patternHandler?(uniqueIdOfCurrentPattern)
        resetScreen()
    }
    
    func cell(at index: Int) -> Circle? {
        guard index >= 0 && index < numberOfCircles else { return nil }
        return viewWithTag((index/size+kSeed)*kTagId+index % size + kSeed) as? Circle
    }
    
    func index(of circle: Circle) -> Int {
        return (circle.tag/kTagId - kSeed)*size + (circle.tag % kTagId - kSeed)
    }
    
    func index(_ point: CGPoint) -> Int {
        for view in self.subviews {
            if let circle = view as? Circle, circle.frame.contains(point) {
                if circle.isSelected == false {
                    circle.isSelected = true
                    currentCellIndex = index(of: circle)
                    selectedCircle = circle
                } else if circle.isSelected == true && allowClosedPattern == true {
                    currentCellIndex = index(of: circle)
                    selectedCircle = circle
                }
                
                let row = circle.tag/kTagId - kSeed
                let col = circle.tag % kTagId - kSeed
                return row * size + col
            }
        }
        return -1
    }
    
    func handlePan(at point: CGPoint) {
        oldCellIndex = currentCellIndex
        let cellPos = index(point) // This part will also change currentCellIndex
        if cellPos >= 0 && cellPos != oldCellIndex && allowClosedPattern == true  {
            
            cellsInOrder.append(currentCellIndex)
            
        }else if cellPos >= 0 && cellPos != oldCellIndex && allowClosedPattern == false && cellsInOrder.count < size*size{
            
            cellsInOrder.append(currentCellIndex)

        }
        print(finalLines)
        if cellPos < 0 && oldCellIndex < 0 {
            return
        } else if cellPos < 0, let circle = cell(at: oldCellIndex) {
            let line = Line(fromPoint: circle.center, toPoint: point, isFullLength: false)
            patternView.lines = []
            patternView.lines.append(contentsOf: finalLines)
            patternView.lines.append(line)
            patternView.setNeedsDisplay()
        } else if cellPos >= 0 && currentCellIndex == oldCellIndex {
            return
        } else if cellPos >= 0 && oldCellIndex == -1 {
            return
        } else if cellPos >= 0 && oldCellIndex != currentCellIndex {
            let uniqueId = uniqueLineIdJoining(cellA: oldCellIndex, cellB: currentCellIndex)
            if drawnLines.index(of: uniqueId) == nil, let circle = cell(at: oldCellIndex), let selected = selectedCircle {
                let line = Line(fromPoint: circle.center, toPoint: selected.center, isFullLength: true)
                finalLines.append(line)
                patternView.lines = []
                patternView.lines.append(contentsOf: finalLines)
                drawnLines.append(uniqueId)
            }
        } else {
            return
        }
        
    }
    
    func uniqueLineIdJoining(cellA: Int, cellB: Int) -> Int {
        return abs(cellA+cellB)*kAlter1 + abs(cellA-cellB)*kAlter2
    }
    
    var uniqueIdOfCurrentPattern: String {

        let stringRepresentation = cellsInOrder.map{"\($0)"}.reduce(""){$0+$1}//"0110"
        return stringRepresentation
    }
    
    func resetScreen() {
        for view in self.subviews {
            if let circle = view as? Circle { circle.isSelected = false }
        }
        finalLines = []
        drawnLines = []
        cellsInOrder = []
        patternView.lines = []
        oldCellIndex = -1
        currentCellIndex = -1
        selectedCircle = nil
    }
    
}
