/*
 **The MIT License**
 **Copyright © 2017 Hanping Xu**
 **All rights reserved.**
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import UIKit

// MARK: - ELPickerView
/// The Picker View With Animation
open class ELPickerView<T: ELPikcerDataType>: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - Settings
    
    /// Type of Picker View
    public let pickerType: ELPickerViewType
    
    /// Background of the screen  Default value is true
    public var blackBackground: Bool = true {
        didSet {
            backgroundView.backgroundColor = blackBackground ? UIColor.init(white: 0/255, alpha: 0.4) : UIColor.clear
        }
    }
    
    var componentWidthFactor: [ = <#value#>
    
    
    /// Set Title Bar hidden or not  Default value is false
    public var isTitleBarHidden: Bool {
        set {
            foregroundView.titleBar.isHidden = newValue
        }
        get {
            return foregroundView.titleBar.isHidden
        }
    }
    
    /// Set Taping Background to hide Picker View enabled or not  Default value is true
    public var isTapBackgroundEnabled: Bool {
        set {
            backgroundView.isEnabled = newValue
        }
        get {
            return backgroundView.isEnabled
        }
    }

    // MARK: - ItemOperation
    
    /// Items used to config Picker View rows  Default value is []
    public var items: [T] {
        didSet {
            foregroundView.picker.reloadAllComponents()
        }
    }
    
    // MARK: - Handler
    
    public typealias ItemTransformHandler = (_ item: T) -> String
    
    /// Function used to transform Item into String. If the Item is String kind, itemConfigHandler is not necessory to be set.
    public func setItemTransformHandler(_ handler: @escaping ItemTransformHandler) {
        itemTransformHandler = handler
    }
    
    public private(set) var itemTransformHandler: ItemTransformHandler = { (item) -> String in
        if let convertableString = item as? CustomStringConvertible {
            return convertableString.description
        }
        return "Item inconvertable !"
    }
    
    public typealias InteractionHandler = (_ view: ELPickerView<T>?, _ chosenIndex: Int, _ chosenItem: T) -> (shouldHide: Bool, animated: Bool)
    
    /// Triggered when Left Button is tapped.
    //  view: the CustomPickerView
    //  chosenIndex: the current chosen index of row in Picker View
    //  chosenItem: the Item connected with the chosen row
    //  shouldHide: tell the Picker View whether it should be hide  Default value is true
    //  animated: tell the Picker View whether the hide action should have animation  Default value is true
    public func setLeftButtoTapHandler(_ handler:@escaping InteractionHandler) {
        leftButtoTapHandler = handler
    }
    
    public private(set) var leftButtoTapHandler: InteractionHandler = { _, _, _ in
        return (true, true)
    }
    
    /// Triggered when Right Button is tapped.
    //  view: the CustomPickerView
    //  chosenIndex: the current chosen index of row in Picker View
    //  chosenItem: the Item connected with the chosen row
    //  shouldHide: tell the Picker View whether it should be hide  Default value is true
    //  animated: tell the Picker View whether the hide action should have animation  Default value is true
    public func setRightButtoTapHandler(_ handler:@escaping InteractionHandler) {
        rightButtoTapHandler = handler
    }
    
    public private(set) var rightButtoTapHandler: InteractionHandler = { _, _, _ in
        return (true, true)
    }
    
    /// Triggered when user picked one row in Picker View.
    //  view: the CustomPickerView
    //  chosenIndex: the current chosen index of row in Picker View
    //  chosenItem: the Item connected with the chosen row
    //  shouldHide: tell the Picker View whether it should be hide  Default value is false
    //  animated: tell the Picker View whether the hide action should have animation   Default value is false
    public func setDidScrollHandler(_ handler:@escaping InteractionHandler) {
        didScrollHandler = handler
    }
    
    public private(set) var didScrollHandler: InteractionHandler = { _, _, _ in
        return (false, true)
    }
    
    public typealias AnimationHandler = (_ view: ELPickerView<T>?) -> Void
    
    /// Triggered when Picker View will show
    public func setWillShowHandler(_ handler: @escaping AnimationHandler) {
        willShowHandler = handler
    }
    
    public private(set) var willShowHandler: AnimationHandler?
    
    /// Triggered when Picker View did show
    public func setDidShowHandler(_ handler: @escaping AnimationHandler) {
        didShowHandler = handler
    }
    
    public private(set) var didShowHandler: AnimationHandler?
    
    /// Triggered when Picker View will hide
    public func setWillHideHandler(_ handler: @escaping AnimationHandler) {
        willHideHandler = handler
    }
    
    public private(set) var willHideHandler: AnimationHandler?
    
    /// Triggered when Picker View did hide
    public func setDidHideHandler(_ handler: @escaping AnimationHandler) {
        didHideHandler = handler
    }
    
    public private(set) var didHideHandler: AnimationHandler?
    
    // MARK: - Views
    
    /// The bottom view containing Title Bar and Picker
    public lazy var foregroundView: ELPickerForegroundView = {
        let picker = ELPickerForegroundView(pickerType: self.pickerType)
        picker.backgroundColor = UIColor.white
        picker.leftButton.addTarget(self, action: #selector(didTapLeftButton(_:)), for: .touchUpInside)
        picker.rightButton.addTarget(self, action: #selector(didTapRightButton(_:)), for: .touchUpInside)
        picker.picker.delegate = self
        picker.picker.dataSource = self
        return picker
    }()
    
    /// Background view
    public lazy var backgroundView: UIControl = {
        let view = UIControl(frame: .null)
        view.backgroundColor = UIColor.init(white: 0/255, alpha: 0.4)
        view.addTarget(self, action: #selector(didTapBackground(_:)), for: .touchUpInside)
        return view
    }()
    
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
    
    
    // MARK: - LifeCircle
    
    /// Init
    ///
    /// - Parameters:
    ///   - pickerType: CustomPickerViewType
    ///   - items: items used as datasource of rows in Picker View
    public init(pickerType: ELPickerViewType, items: [T]) {
        self.pickerType = pickerType
        self.items = items
        super.init(frame: .null)
        setupViews()
        setupFrame()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Setup views
    public func setupViews() {
        addSubview(backgroundView)
        addSubview(foregroundView)
        backgroundColor = UIColor.clear
        clipsToBounds = true
    }
    
    /// Setup frame
    public func setupFrame() {
        foregroundView.frame = CGRect(x: 0, y: screenHeight * 1.5, width: screenWidth, height: 260)
    }
    
    // MARK: - Delegate DataSource
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return itemTransformHandler(items[row])
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        weak var weakSelf = self
        let interact = didScrollHandler(weakSelf, row, items[row])
        if interact.shouldHide {
            hide(animated: interact.animated)
        }
    }
    
    
    // MARK: - Interaction
    
    /// Tap background action
    ///
    /// - Parameter sender: sender
    @objc public func didTapBackground(_ sender: Any) {
        hide(animated: true)
    }
    
    /// Tap left button action
    ///
    /// - Parameter button: button
    @objc public func didTapLeftButton(_ button: UIButton) {
        weak var weakSelf = self
        let index = foregroundView.picker.selectedRow(inComponent: 0)
        let interact = leftButtoTapHandler(weakSelf, index, items[index])
        if interact.shouldHide {
            hide(animated: interact.animated)
        }
    }
    
    /// Tap right button action
    ///
    /// - Parameter button: button
    @objc public func didTapRightButton(_ button: UIButton) {
        weak var weakSelf = self
        let index = foregroundView.picker.selectedRow(inComponent: 0)
        let interact = rightButtoTapHandler(weakSelf, index, items[index])
        if interact.shouldHide {
            hide(animated: interact.animated)
        }
    }
    
    /// Let ViewController/Window show Picker View
    ///
    /// - Parameters:
    ///   - viewController: If viewController is available, the Picker View will be add to viewController.view. If viewController is nil, the Picker View will be add to the showing window.
    ///   - animated: animated
    public func show(viewController: UIViewController?, animated: Bool) {
        weak var weakSelf = self
        if let ctrl = viewController  {
            frame = CGRect(x: 0, y: 0, width: screenWidth, height: ctrl.view.frame.height)
            ctrl.view.addSubview(self)
        }
        else {
            let window = UIApplication.shared.windows[0]
            frame = window.frame
            window.addSubview(self)
        }
        foregroundView.frame = CGRect(x: 0, y: frame.height, width: screenWidth, height: 260)
        backgroundView.frame = frame
        if let handler = willShowHandler {
            handler(weakSelf)
        }
        UIView.animate(withDuration: animated ? 0.5 : 0, animations: {
            self.foregroundView.frame = CGRect(x: 0, y: self.frame.height - 260, width: screenWidth, height: 260)
        }) { (success) in
            if let handler = self.didShowHandler {
                handler(weakSelf)
            }
        }
    }
    
    /// Set Picker View Hide
    ///
    /// - Parameter animated: animated
    public func hide(animated: Bool) {
        weak var weakSelf = self
        if let handler = willHideHandler {
            handler(weakSelf)
        }
        UIView.animate(withDuration: animated ? 0.5 : 0, animations: {
            self.foregroundView.frame = CGRect(x: 0, y: self.frame.height, width: screenWidth, height: 260)
        }) { (success) in
            self.removeFromSuperview()
            if let handler = self.didHideHandler {
                handler(weakSelf)
            }
        }
    }
}

// MARK: - ELPickerForegroundView

/// The view holding TitleBar and Picker
open class ELPickerForegroundView: UIView {
    
    /// CustomPickerViewType
    public let pickerType: ELPickerViewType
    
    /// Left Button of Title Bar
    lazy var leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("leftButton", for: .normal)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    /// Right Button of Title Bar
    lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("rightButton", for: .normal)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    /// Title of Title Bar
    lazy var title: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "label\ndescription"
        return label
    }()
    /// Title Bar
    public lazy var titleBar: UIView = {
        let view = UIView(frame: .null)
        view.backgroundColor = UIColor.white
        return view
    }()
    /// Top Divider of Title Bar
    public lazy var topDivider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    /// Bottom Divider of Title Bar
    public lazy var bottomDivider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    /// Picker
    public lazy var picker: UIPickerView = {
        let picker = UIPickerView(frame: .null)
        return picker
    }()
    
    /// Setup Views
    public func setupViews() {
        backgroundColor = UIColor.clear
        addSubview(titleBar)
        titleBar.clipsToBounds = false
        titleBar.addSubview(title)
        titleBar.addSubview(leftButton)
        titleBar.addSubview(rightButton)
        titleBar.addSubview(topDivider)
        titleBar.addSubview(bottomDivider)
        addSubview(picker)
    }
    
    /// Setup Frame
    public func setupFrame() {
        titleBar.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 44)
        topDivider.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0.5)
        bottomDivider.frame = CGRect(x: 0, y: titleBar.frame.height - 0.5, width: screenWidth, height: 0.5)
        title.frame = CGRect(x: screenWidth/4, y: 0, width: screenWidth/2, height: 44)
        leftButton.frame = CGRect(x: 0, y: 0, width: screenWidth / 4, height: 44)
        rightButton.frame = CGRect(x: screenWidth * 3/4, y: 0, width: screenWidth / 4, height: 44)
        picker.frame = CGRect(x: 0, y: 44, width: screenWidth, height: 216)
    }
    
    /// Init
    ///
    /// - Parameter pickerType: CustomPickerViewType
    public init(pickerType: ELPickerViewType) {
        self.pickerType = pickerType
        super.init(frame: .null)
        setupViews()
        setupFrame()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
