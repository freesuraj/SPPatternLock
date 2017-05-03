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
        let _slider = UISlider(frame: CGRect(x: 100, y: 60, width: self.view.frame.width - 120, height: 50))
        _slider.minimumValue = 3
        _slider.maximumValue = 7
        _slider.addTarget(self, action: #selector(onDrag), for: .valueChanged)
        return _slider
    }()
    
    lazy var complexSwitch: UISwitch = {
        let _switch = UISwitch(frame: CGRect(x: 200, y: 120, width: 40, height: 50))
        _switch.addTarget(self, action: #selector(onSwitch), for: .valueChanged)
        _switch.isOn = true
        return _switch
    }()
    
    private var currentSize: Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelSlider = UILabel(frame: CGRect(x: 10, y: 80, width: 100, height: 30))
        labelSlider.text = "Grid size"
        labelSlider.sizeToFit()
        view.addSubview(labelSlider)
        view.addSubview(slider)
        
        let labelSwitch = UILabel(frame: CGRect(x: 10, y: 130, width: 100, height: 30))
        labelSwitch.text = "Allow Complex"
        labelSwitch.sizeToFit()
        view.addSubview(labelSwitch)
        view.addSubview(complexSwitch)
        
        title = "SPPatternLock - version 2"
        view.backgroundColor = UIColor.lightGray
        
        updateLockScreen(withSize: currentSize, allowComplex: true)
    }
    
    func updateLockScreen(withSize size: Int, allowComplex: Bool) {
        title = "\(size)x\(size) pattern lock"
        if let v = lockScreenView { v.removeFromSuperview() }
        let lockFrame = CGRect(origin: CGPoint(x: 0, y: complexSwitch.frame.maxY+10), size: CGSize(width: view.frame.width, height: view.frame.width))
        // Example of using config
        var config = LockScreen.Config()
        config.lineColor = UIColor.purple
        lockScreenView = LockScreen(frame: lockFrame, size: size, allowClosedPattern: allowComplex, config: config) { [weak self] (pattern, order) in
            print(order.description)
            print(pattern)
            self?.title = "\(pattern)"
        }
        view.addSubview(lockScreenView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onSwitch(sender: AnyClass) {
        updateLockScreen(withSize: currentSize, allowComplex: complexSwitch.isOn)
    }
    
    func onDrag(sender: AnyClass) {
        let size = Int(slider.value)
        if size != currentSize {
            updateLockScreen(withSize: size, allowComplex: complexSwitch.isOn)
            currentSize = size
        }
    }


}

