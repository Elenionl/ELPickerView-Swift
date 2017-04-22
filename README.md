ELPickerView: Easily Used Picker View build with Swift 3
======================================

[![Build Status](https://travis-ci.org/Elenionl/ELPickerView-Swift.svg?branch=master)](https://travis-ci.org/Elenionl/ELPickerView-Swift)
[![CocoaPods](https://img.shields.io/cocoapods/v/ELPickerView.svg?style=flat)](https://cocoapods.org/pods/ELPickerView)
[![CocoaPods](https://img.shields.io/cocoapods/l/ELPickerView.svg?style=flat)](https://cocoapods.org/pods/ELPickerView)
[![Platform](https://img.shields.io/cocoapods/p/ELPickerView.svg?style=flat)](https://cocoapods.org/pods/ELPickerView)


**:warning: ELPickerView requires Swift Version higher than 3.0.**

## 请点击[中文说明](https://github.com/Elenionl/ELPickerView-Swift/blob/master/README%20IN%20CHINESE.md)


## Screenshots
Easily Used Picker View build with Swift 3


![screenshots_4](https://raw.githubusercontent.com/Elenionl/ELPickerView-Swift/master/screenshots/screenshots_4.gif)
----------------------

## How to Install

### Using [CocoaPods](http://cocoapods.org)

* Add this line to your ``podfile`` :
``pod 'RxSwift'``
* Run `pod install` with Terminal
* Then everything is done!
-----------------------
### Simply add

* Open [Elenionl/ELPickerView-Swift](https://github.com/Elenionl/ELPickerView-Swift) with browser
* Download or Clone Project: ``https://github.com/Elenionl/ELPickerView-Swift.git``
* Copy ``ELCustomPickerView.swift`` file to your project
* Enjoy
-------------

## How to Use

### If you want to show a Picker View in your application. Simply do these two steps:
* init
```Swift
lazy var customPickerView: ELCustomPickerView<String> = {
    return ELCustomPickerView<String>(pickerType: .singleComponent, items: [
        "Row 0"
        , "Row 1"
        , "Row 2"
        , "Row 3"
        , "Row 4"
        , "Row 5"
        ])
}
```
* show
```Swift
override func viewDidLoad() {
        super.viewDidLoad()
        customPickerView.show(viewController: self, animated: true)
}
```
----------------------
### If You Want the Translucent Background to Cover the Navigation Bar and the Tab Background

* Just let the window show Picker View like this:

```Swift
    override func viewDidLoad() {
        super.viewDidLoad()
        customPickerView.show(viewController: nil, animated: true)
    }
```
--------------
### Instead of Delegate, ELPickerView Use Closure to Handle Callback

* There are rich callbacks as follow:
```Swift
        customPickerView.leftButtoTapHandler = { [weak self] (view: ELCustomPickerView<String>?, chosenIndex: Int, chosenItem: (key: String, content: String)) in
            let hide = true
            let animated = true
            self?.logLabel.text = "Did Tap Left Button. <Index: \(chosenIndex)> <chosenItem: \(chosenItem)> <Hide: \(hide)> <Animated: \(animated)>"
            print(self?.logLabel.text ?? "")
            return (hide, animated)
        }
```

* And here is the define and meaning of the handler:

```Swift
    /// Triggered when Left Button is tapped.
    //  view: the CustomPickerView
    //  chosenIndex: the current chosen index of row in Picker View
    //  chosenItem: the Item connected with the chosen row
    //  shouldHide: tell the Picker View whether it should be hide  Default value is true
    //  animated: tell the Picker View whether the hide action should have animation  Default value is true
    public var leftButtoTapHandler: ((_ view: ELCustomPickerView?, _ chosenIndex: Int, _ chosenItem: T) -> (shouldHide: Bool, animated: Bool))?
```
--------------------------
### You Can Let Users Pick Between Instance, Struct, Enum, Tuple

* Add whatever kind of items when init:
```Swift
typealias CustomView = ELCustomPickerView<(key: String, content: String)>
...
let view = CustomView(pickerType: .singleComponent, items: [
          ("00", "Row 0")
          , ("02", "Row 1")
          , ("04", "Row 2")
          , ("06", "Row 3")
          , ("09", "Row 4")
          , ("11", "Row 5")
          ])
```

* Give a handler to transform item into a String kind var
```Swift
view.itemConfigHandler = { (key: String, content: String) in
    return content
}
```

* Then Done
--------------------
### View is Easily Customizable

```Swift
        view.blackBackground = true
        view.isTitleBarHidden = false
        view.isTapBackgroundEnabled = true
        view.leftButton.setTitle("LEFT", for: .normal)
        view.rightButton.setTitle("RIGHT", for: .normal)
        view.title.text = "TITLE"
        view.foregroundView.picker.backgroundColor = UIColor.white
        view.foregroundView.bottomDivider.isHidden = true
```
-----------------
## Settings and Handlers Available

```Swift
// MARK: - Settings

/// Type of Picker View
public let pickerType: ELCustomPickerViewType

/// Items used to config Picker View rows  Default value is []
public var items: [T]

/// Background of the screen  Default value is true
public var blackBackground: Bool

/// Set Title Bar hidden or not  Default value is false
public var isTitleBarHidden = false

/// Set Taping Background to hide Picker View enabled or not  Default value is true
public var isTapBackgroundEnabled = true

/// Left Button of the Title Bar, shortcut to foregroundView.leftButton
public lazy var leftButton: UIButton

/// Right Button of the Title Bar, shortcut to foregroundView.rightButton
public lazy var rightButton: UIButton

/// Title of the Title Bar, shortcut to foregroundView.title
public lazy var title: UILabel


// MARK: - Handler

/// Function used to transform Item into String. If the Item is String kind, itemConfigHandler is not necessory to be set.
public var itemConfigHandler: ((T) -> String)?
/// Triggered when Left Button is tapped.
//  view: the CustomPickerView
//  chosenIndex: the current chosen index of row in Picker View
//  chosenItem: the Item connected with the chosen row
//  shouldHide: tell the Picker View whether it should be hide  Default value is true
//  animated: tell the Picker View whether the hide action should have animation  Default value is true
public var leftButtoTapHandler: ((_ view: ELCustomPickerView?, _ chosenIndex: Int, _ chosenItem: T) -> (shouldHide: Bool, animated: Bool))?
/// Triggered when Right Button is tapped.
//  view: the CustomPickerView
//  chosenIndex: the current chosen index of row in Picker View
//  chosenItem: the Item connected with the chosen row
//  shouldHide: tell the Picker View whether it should be hide  Default value is true
//  animated: tell the Picker View whether the hide action should have animation  Default value is true
public var rightButtoTapHandler: ((_ view: ELCustomPickerView?, _ chosenIndex: Int, _ chosenItem: T) -> (shouldHide: Bool, animated: Bool))?
/// Triggered when user picked one row in Picker View.
//  view: the CustomPickerView
//  chosenIndex: the current chosen index of row in Picker View
//  chosenItem: the Item connected with the chosen row
//  shouldHide: tell the Picker View whether it should be hide  Default value is false
//  animated: tell the Picker View whether the hide action should have animation   Default value is false
public var didScrollHandler: ((_ view: ELCustomPickerView?, _ chosenIndex: Int, _ chosenItem: T) -> (shouldHide: Bool, animated: Bool))?
/// Triggered when Picker View will show
public var willShowHandler: ((_ view: ELCustomPickerView?) -> Void)?
/// Triggered when Picker View did show
public var didShowHandler: ((_ view: ELCustomPickerView?) -> Void)?
/// Triggered when Picker View will hide
public var willHideHandler: ((_ view: ELCustomPickerView?) -> Void)?
/// Triggered when Picker View did hide
public var didHideHandler: ((_ view: ELCustomPickerView?) -> Void)?
lazy var tapBackground: UITapGestureRecognizer = {
    let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackground(_:)))
    gesture.numberOfTapsRequired = 1
    return gesture
}()

// MARK: - Views

/// The bottom view containing Title Bar and Picker
public lazy var foregroundView: ELPickerForegroundView
```
------------
## Requirements

* Xcode 8.0
* Swift 3.0
* Using ARC
--------------
## Author

Hanping Xu ([Elenionl](https://github.com/Elenionl)), stellanxu@gmail.com


--------------------------
## License

ELPickerView is available under the MIT license, see the LICENSE file for more information.   
