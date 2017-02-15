[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/PatternLock.svg)](http://cocoadocs.org/docsets/PatternLock/)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/PatternLock.svg?style=flat)](http://cocoadocs.org/docsets/PatternLock)
[![Twitter](https://img.shields.io/badge/twitter-@iosCook-blue.svg?style=flat)](http://twitter.com/iosCook)
[![GitHub stars](https://img.shields.io/github/stars/freesuraj/patternlock.svg?style=social&label=Star)](https://github.com/freesuraj/SPPatternlock)
[![GitHub forks](https://img.shields.io/github/forks/freesuraj/patternlock.svg?style=social&label=Fork)](https://github.com/freesuraj/SPPatternlock)

Pattern Lock for iOS
========================
Revamped PatternLock for iOS written in Swift3.

![ScreenShot](https://github.com/freesuraj/SPPatternLock/blob/Swift/Examples/patternLock.png?raw=true)


* **no graphics or images**
* **all colors and sizes are customizable**
* **can enable closed-type(complex type) patterns**
* **support for both iPhone and iPad**
* **Easy to bring in and use**

### Cocoapods
		pod 'PatternLock'
### Initialization

```swift
		/**
     Initializes the main lock screen
     
     - parameter frame: `CGRect` where the screen will be drawn
     - parameter size: Size of the lock screen. It will create grids of size X size. Default value is 3
     - parameter allowClosedPattern: If set to `true`, it allows for complicated pattern. Otherwise a circle can't be used twice for a pattern
     - parameter handler: Callback to receive the user pattern
     - returns: Returns the Lock screen
     */
    convenience init(frame: CGRect, size: Int = 3, allowClosedPattern: Bool = true, handler: PatternHandlerBlock? = nil)
    ```


## About

If you found this little tool useful, I'd love to hear about it. You can also follow me on Twitter at [@iosCook](https://twitter.com/ioscook)


[![GitHub followers](https://img.shields.io/github/followers/freesuraj.svg?style=social&label=Follow)](https://github.com/freesuraj)