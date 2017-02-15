//
//  ViewController.swift
//  SPPatternLock
//
//  Created by Suraj Pathak on 14/2/17.
//  Copyright © 2017 Suraj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var lockScreenView: LockScreen!
    lazy var slider: UISlider = {
        let _slider = UISlider(frame: CGRect(x: 20, y: 60, width: self.view.frame.width - 40, height: 50))
        _slider.minimumValue = 3
        _slider.maximumValue = 7
        _slider.addTarget(self, action: #selector(onDrag), for: .valueChanged)
        return _slider
    }()
    
    lazy var complexSwitch: UISwitch = {
        let _switch = UISwitch(frame: CGRect(x: 20, y: 120, width: 40, height: 50))
        
        return _switch
    }()
    
    private var currentSize: Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(slider)
        title = "SPPatternLock - version 2"
        view.backgroundColor = UIColor.white
        updateLockScreen(withSize: currentSize)
    }
    
    func updateLockScreen(withSize size: Int) {
        title = "\(size)x\(size) pattern lock"
        if let v = lockScreenView { v.removeFromSuperview() }
        let lockFrame = CGRect(origin: CGPoint(x: 0, y: 100), size: CGSize(width: view.frame.width, height: view.frame.width))
        lockScreenView = LockScreen(frame: lockFrame, numberOfCircles: size*size, allowClosedPattern: true) { [weak self] pattern in
            self?.title = "\(pattern)"
        }
        view.addSubview(lockScreenView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onDrag(sender: AnyClass) {
        let size = Int(slider.value)
        if size != currentSize {
            updateLockScreen(withSize: size)
            currentSize = size
        }
    }


}

