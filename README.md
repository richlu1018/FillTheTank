# FillTheTank
![image](https://j.gifs.com/6XG4Vz.gif)

A customizable container view with options for filling up animation.

[![Build status](https://travis-ci.com/richlu1018/FillTheTank.svg?branch=master)](https://travis-ci.com/richlu1018/FillTheTank)
[![License](https://img.shields.io/cocoapods/l/FillTheTank.svg?style=flat)](https://cocoapods.org/pods/FillTheTank) 
[![Platform](https://img.shields.io/cocoapods/p/FillTheTank.svg?style=flat)](http://cocoadocs.org/docsets/FillTheTank) 
[![CocoaPod](https://img.shields.io/cocoapods/v/FillTheTank.svg?style=flat)](https://cocoapods.org/pods/FillTheTank)

## What's New In v1.2.0
- LevelManager can be updated with direction, color and duration to create more interesting animations 

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
Next, create a LevelManager first to determine some basic variants.

- directions: bottomUp⬆️, topDown⬇️, leftToRight➡️, rightToLeft⬅️ 

- countDownDuration: level movement animation duration

- level: value within 0~1, 0: empty 1: full

- fillingsColor: color of containter fillings

```swift
let manager = LevelManager(moveWithDirection: .leftToRight, duration: 2.0, initLevel: 0.0, fillingsColor: .orange)
```

Now we can create our Tank view with the FillUpManager object and do some UI customization: 
```swift
// Title label text attributes
let textAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]

// Initial tank view with LevelManager
let tank = Tank(lvManager: manager)
            .cornerRadius(10.0)
            .borderColor(.orange)
            .borderWidth(3.0)
            .backgroundColor(.white)
            .dismissWhenTankIsFull(true)
            .titleLabel(attributedString: "pod \"FillTheTank\"",
                       withAttributes: textAttributes)

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
// If dismissWhenThankIsFill is set to TRUE and no custom completion block defined, 
// tank view will be removed from superview when animation completed

tank.fillUptheTank()
```
Or you can also define your own completion block (By defining custom completion block, you have to manually remove tank view from superview when needed):
```swift

tank.fillUptheTank { (_) in
    print("Tank is full!")
    // Call dismiss() function to remove from superview
    tank.dismiss()
}
```
Tank level change can also be done by updating the next level ratio:
```swift
tank.update(level: 0.8)
```

# Credits

FillTheTank is owned and maintained by Richard Lu (richlu1018@gmail.com)
                             
# License

MIT License

Copyright (c) 2019 richlu1018

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
                             i
                             
                             
