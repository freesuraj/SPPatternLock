Pattern Lock for iOS
========================
<i> A simple but fully functional pattern lock sdk for iOS (similar to the android pattern lock) </i>

![ScreenShot](http://www.pictureshoster.com/files/ngbk591w5pcz9gbuydg.png)


* **no graphics or images**
* **all colors and sizes are customizable**
* **can enable closed-type(complex type) patterns, off by default**
* **support for both iPhone and iPad**
* **Easy to bring in and use**

### How to Use

### Cocoapods

		pod 'PatternLock'

#### init

		- (id)initWithDelegate:(id)lockDelegate
		
#### recognize a pattern

		- (void)lockScreen:(SPLockScreen *)lockScreen didEndWithPattern:(NSNumber *)patternNumber		


**Do however you want to do with the match**

**That's it !**

Contact
==========
You can contact me at my email freesuraj@gmail.com for any questions.