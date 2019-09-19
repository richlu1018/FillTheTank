# FillTheTank
A customizable container view with options for filling up animation.

[![Build status](https://travis-ci.com/richlu1018/FillTheTank.svg?branch=master)](https://travis-ci.com/richlu1018/FillTheTank)
[![License](https://img.shields.io/cocoapods/l/FillTheTank.svg?style=flat)](https://cocoapods.org/pods/FillTheTank) 
[![Platform](https://img.shields.io/cocoapods/p/FillTheTank.svg?style=flat)](http://cocoadocs.org/docsets/FillTheTank) 
[![CocoaPod](https://img.shields.io/cocoapods/v/FillTheTank.svg?style=flat)](https://cocoapods.org/pods/FillTheTank)


## Installation

To install FillTheTank using CocoaPods, include the following in your Podfile

```ruby
pod 'FillTheTank'
```

## How To

First, import FillTheTank module
```swift
import FillTheTank
```
Next, create a FillUpManager first to determine some basic variants.
There are 2 filling up animation options: 
 - Constantly - Fill up the tank(container view) linealy under specified duration
 - Progressively - Tank will animate to fill up to assigned ratio (0~1, 0: empty, 1: full)  

Filling up animation option has to be determined while initiating FillUpManager.

For constantly fill up option, FillUpManager is initiated like below with designated fill up direction, countDownDuration and fillUpColor:
```swift
let manager = FillUpManager(constantlyFillUpWithDirection: .bottmUp, countDownDuration: 5, fillUpColor: .blue)
```
There are 4 fill up directions for now, bottomUp⬆️, topDown⬇️, leftToRight➡️, rightToLeft⬅️

For progressively fill up options, initialization is same as above except we need to assign a initial progress ratio instead of a countDownDuration: 
```swift
let manager = FillUpManager(progressivelyFillUpWithDirection: .bottmUp, initialProgress: 0.0, fillUpColor: .gray)
```

Now we can create our Tank view with the FillUpManager object and do some UI customization: 
```swift
let tank = Tank(manager: manager)
            .backgroundColor(.black)
            .borderWidth(3.0)
            .borderColor(.gray)
            .cornerRadius(10.0)
            .dismissWhenTankIsFull(true)

// Add tank into view hierarchy
view.addSubView(tank)

// Set up constraints
NSLayoutConstraint.activate([tank.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                             tank.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                             tank.widthAnchor.constraint(equalTo:view.widthAnchor),
                             tank.heightAnchor.constraint(equalTo: view.heightAnchor)])
```

Let's fill up the tank:
```swift
// For constantly fill up option without defining completion block
// If dismissWhenThankIsFill is set to TRUE, 
// tank view will be removed from superview when animation completed

tank.filltheTank() 
```
Or you can also define your own completion block (By defining custom completion block, you have to manually remove tank view from superview when needed):
```swift

tank.filltheTank { (_) in
    print("Tank is full!")
    // Call dismiss() function to remove from superview
    tank.dismiss()
}
```
If your using progressively fill up option, the tank is fill up by updating the next fill ratio:
```swift
tank.update(fillingProgress: 0.8)
```

# Credits

FillTheTank is owned and maintained by Richard Lu (richlu1018@gmail.com)
                             
