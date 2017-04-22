ELPickerView: Easily Used Picker View build with Swift 3
======================================

[![CocoaPods](https://img.shields.io/cocoapods/dt/ELPickerView.svg?style=flat)](https://cocoapods.org/pods/ELPickerView)
[![CocoaPods](https://img.shields.io/cocoapods/v/ELPickerView.svg?style=flat)](https://cocoapods.org/pods/ELPickerView)
[![CocoaPods](https://img.shields.io/cocoapods/l/ELPickerView.svg?style=flat)](https://cocoapods.org/pods/ELPickerView)
[![Platform](https://img.shields.io/cocoapods/p/ELPickerView.svg?style=flat)](https://cocoapods.org/pods/ELPickerView)

**:warning: ELPickerView requires Swift Version higher than 3.0.**

## Screenshots
Easily Used Picker View build with Swift 3
[screenshots_1](https://raw.githubusercontent.com/Elenionl/ELPickerView-Swift/master/screenshots/screenshots_1.png)
[screenshots_2](https://raw.githubusercontent.com/Elenionl/ELPickerView-Swift/master/screenshots/screenshots_2.png)
[screenshots_3](https://raw.githubusercontent.com/Elenionl/ELPickerView-Swift/master/screenshots/screenshots_3.gif)

## How to Install

#### Using [CocoaPods](http://cocoapods.org)

* Add this line to your 'podfile' :
```ruby
pod 'RxSwift'
```
* Run `pod install`, then everything is done!

#### Simply add
* Open [Elenionl/ELPickerView-Swift](https://github.com/Elenionl/ELPickerView-Swift)
* Download or Clone Project: ``https://github.com/Elenionl/ELPickerView-Swift.git``
* Copy 'ELCustomPickerView.swift' file to your project
* Enjoy


## How to Use
#### If you want to show a Picker View in your application. Simply do these two steps:
1. init
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
1. show
```Swift
override func viewDidLoad() {
        super.viewDidLoad()
        customPickerView.show(viewController: self, animated: true)
}
```
#### If You Want the Translucent Background to Cover the Navigation Bar and the Tab Background

Just let the window show Picker View like this:

```Swift
    override func viewDidLoad() {
        super.viewDidLoad()
        customPickerView.show(viewController: nil, animated: true)
    }
```

#### Instead of Delegate, ELPickerView Use Closure to Handle Callback

There are rich callbacks as follow:
```Swift
        customPickerView.leftButtoTapHandler = { [weak self] (view: ELCustomPickerView<String>?, chosenIndex: Int, chosenItem: (key: String, content: String)) in
            let hide = true
            let animated = true
            self?.logLabel.text = "Did Tap Left Button. <Index: \(chosenIndex)> <chosenItem: \(chosenItem)> <Hide: \(hide)> <Animated: \(animated)>"
            print(self?.logLabel.text ?? "")
            return (hide, animated)
        }
```
And here is the define and meaning of the handler:
```Swift
    /// Triggered when Left Button is tapped.
    //  view: the CustomPickerView
    //  chosenIndex: the current chosen index of row in Picker View
    //  chosenItem: the Item connected with the chosen row
    //  shouldHide: tell the Picker View whether it should be hide  Default value is true
    //  animated: tell the Picker View whether the hide action should have animation  Default value is true
    public var leftButtoTapHandler: ((_ view: ELCustomPickerView?, _ chosenIndex: Int, _ chosenItem: T) -> (shouldHide: Bool, animated: Bool))?
```

#### You Can Let Users Pick Between Instance, Struct, Enum, Tuple

Add whatever kind of items when init:
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

Give a handler to transform item into a String kind var
```Swift
view.itemConfigHandler = { (key: String, content: String) in
    return content
}
```

Then Done

#### View is Easily Customizable

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

## Settings and Handlers Available

```Swift
// MARK: - Settings

/// Type of Picker View
public let pickerType: ELCustomPickerViewType
/// Items used to config Picker View rows  Default value is []
public var items: [T] {
    didSet {
        foregroundView.picker.reloadAllComponents()
    }
}
/// Background of the screen  Default value is true
public var blackBackground: Bool = true {
    didSet {
        backgroundColor = blackBackground ? UIColor.init(white: 0/255, alpha: 0.4) : UIColor.clear
    }
}
/// Set Title Bar hidden or not  Default value is false
public var isTitleBarHidden = false {
    didSet {
        foregroundView.titleBar.isHidden = isTitleBarHidden
    }
}
/// Set Taping Background to hide Picker View enabled or not  Defualt value is true
public var isTapBackgroundEnabled = true {
    didSet {
        tapBackground.isEnabled = isTapBackgroundEnabled
    }
}
/// Left Button of the Title Bar, shortcut to foregroundView.leftButton
public lazy var leftButton: UIButton = {
    return self.foregroundView.leftButton
}()
/// Right Button of the Title Bar, shortcut to foregroundView.rightButton
public lazy var rightButton: UIButton = {
    return self.foregroundView.rightButton
}()
/// Title of the Title Bar, shortcut to foregroundView.title
public lazy var title: UILabel = {
    return self.foregroundView.title
}()

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
public lazy var foregroundView: ELPickerForegroundView = {
    let picker = ELPickerForegroundView(pickerType: self.pickerType)
    picker.leftButton.addTarget(self, action: #selector(didTapLeftButton(_:)), for: .touchUpInside)
    picker.rightButton.addTarget(self, action: #selector(didTapRightButton(_:)), for: .touchUpInside)
    picker.picker.delegate = self
    picker.picker.dataSource = self
    return picker
}()
```

* All of this is great, but it would be nice to talk with other people using RxSwift and exchange experiences. <br />[![Slack channel](http://rxswift-slack.herokuapp.com/badge.svg)](http://rxswift-slack.herokuapp.com/) [Join Slack Channel](http://rxswift-slack.herokuapp.com)
* Report a problem using the library. [Open an Issue With Bug Template](.github/ISSUE_TEMPLATE.md)
* Request a new feature. [Open an Issue With Feature Request Template](Documentation/NewFeatureRequestTemplate.md)


###### ... compare

* [with other libraries](Documentation/ComparisonWithOtherLibraries.md).


###### ... find compatible

* libraries from [RxSwiftCommunity](https://github.com/RxSwiftCommunity).
* [Pods using RxSwift](https://cocoapods.org/?q=uses%3Arxswift).

###### ... see the broader vision

* Does this exist for Android? [RxJava](https://github.com/ReactiveX/RxJava)
* Where is all of this going, what is the future, what about reactive architectures, how do you design entire apps this way? [Cycle.js](https://github.com/cyclejs/cycle-core) - this is javascript, but [RxJS](https://github.com/Reactive-Extensions/RxJS) is javascript version of Rx.

## Usage

<table>
  <tr>
    <th width="30%">Here's an example</th>
    <th width="30%">In Action</th>
  </tr>
  <tr>
    <td>Define search for GitHub repositories ...</td>
    <th rowspan="9"><img src="https://raw.githubusercontent.com/kzaher/rxswiftcontent/master/GithubSearch.gif"></th>
  </tr>
  <tr>
    <td><div class="highlight highlight-source-swift"><pre>
let searchResults = searchBar.rx.text.orEmpty
    .throttle(0.3, scheduler: MainScheduler.instance)
    .distinctUntilChanged()
    .flatMapLatest { query -> Observable&lt;[Repository]&gt; in
        if query.isEmpty {
            return .just([])
        }
        return searchGitHub(query)
            .catchErrorJustReturn([])
    }
    .observeOn(MainScheduler.instance)</pre></div></td>
  </tr>
  <tr>
    <td>... then bind the results to your tableview</td>
  </tr>
  <tr>
    <td width="30%"><div class="highlight highlight-source-swift"><pre>
searchResults
    .bind(to: tableView.rx.items(cellIdentifier: "Cell")) {
        (index, repository: Repository, cell) in
        cell.textLabel?.text = repository.name
        cell.detailTextLabel?.text = repository.url
    }
    .disposed(by: disposeBag)</pre></div></td>
  </tr>
</table>


## Requirements

* Xcode 8.0
* Swift 3.0
* using ARC

## Author

Hanping Xu ([Elenionl](https://github.com/Elenionl)), stellanxu@gmail.com

## License

ELPickerView is available under the MIT license, see the LICENSE file for more information.   
