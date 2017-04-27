/*
**The MIT License**
**Copyright © 2017 Hanping Xu**
**All rights reserved.**

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import UIKit

typealias CustomView = ELCustomPickerView<(key: String, content: String)>

class ViewController: UIViewController {
    @IBOutlet weak var logLabel: UILabel!
    @IBOutlet weak var showStatus: UILabel!

    @IBAction func showByWindow(_ sender: UIButton) {
        customPickerView.title.text = "Show by Window"
        customPickerView.isTapBackgroundEnabled = true
        customPickerView.blackBackground = true
        customPickerView.isTitleBarHidden = false
        customPickerView.foregroundView.bottomDivider.isHidden = false
        customPickerView.foregroundView.bottomDivider.isHidden = false
        customPickerView.show(viewController: nil, animated: true)
    }
    @IBAction func showByViewController(_ sender: UIButton) {
        customPickerView.title.text = "Show by ViewController"
        customPickerView.isTapBackgroundEnabled = true
        customPickerView.blackBackground = true
        customPickerView.isTitleBarHidden = false
        customPickerView.foregroundView.bottomDivider.isHidden = false
        customPickerView.foregroundView.bottomDivider.isHidden = false
        customPickerView.show(viewController: self, animated: true)
    }
    @IBAction func showWithWhiteBackground(_ sender: UIButton) {
        customPickerView.title.text = "Show With White Background"
        customPickerView.isTapBackgroundEnabled = true
        customPickerView.blackBackground = false
        customPickerView.isTitleBarHidden = false
        customPickerView.foregroundView.bottomDivider.isHidden = false
        customPickerView.foregroundView.bottomDivider.isHidden = false
        customPickerView.show(viewController: self, animated: true)
    }
    @IBAction func showWithoutTitleBar(_ sender: UIButton) {
        customPickerView.title.text = "Show With White Background"
        customPickerView.isTapBackgroundEnabled = true
        customPickerView.blackBackground = true
        customPickerView.isTitleBarHidden = true
        customPickerView.foregroundView.bottomDivider.isHidden = false
        customPickerView.foregroundView.bottomDivider.isHidden = false
        customPickerView.show(viewController: self, animated: true)
    }
    @IBAction func showWithNoDivider(_ sender: UIButton) {
        customPickerView.title.text = "Show With No Divider & Tap Background Disabled"
        customPickerView.isTapBackgroundEnabled = false
        customPickerView.blackBackground = true
        customPickerView.isTitleBarHidden = false
        customPickerView.foregroundView.bottomDivider.isHidden = true
        customPickerView.foregroundView.bottomDivider.isHidden = true
        customPickerView.show(viewController: self, animated: true)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    lazy var customPickerView: CustomView = {
        let view = CustomView(pickerType: .singleComponent, items: [
            ("00", "Row 0")
            , ("02", "Row 1")
            , ("04", "Row 2")
            , ("06", "Row 3")
            , ("09", "Row 4")
            , ("11", "Row 5")
            ])
        // MARK: - Settings
        view.blackBackground = true
        view.isTitleBarHidden = false
        view.isTapBackgroundEnabled = true
        view.leftButton.setTitle("LEFT", for: .normal)
        view.rightButton.setTitle("RIGHT", for: .normal)
        view.title.text = "TITLE"
        view.foregroundView.picker.backgroundColor = UIColor.white
        view.foregroundView.bottomDivider.isHidden = true
        // MARK: - Handler
        view.setItemConfigHandler({ (item) -> String in
            return item.content
        })
        view.setLeftButtoTapHandler({ [weak self] (view, chosenIndex, chosenItem) -> (shouldHide: Bool, animated: Bool) in
            let hide = true
            let animated = true
            self?.logLabel.text = "Did Tap Left Button.\n <Index: \(chosenIndex)> \n<chosenItem: \(chosenItem)> \n<Hide: \(hide)> \n<Animated: \(animated)>"
            print(self?.logLabel.text ?? "")
            return (hide, animated)
        })
        view.setRightButtoTapHandler({ [weak self] (view, chosenIndex, chosenItem) -> (shouldHide: Bool, animated: Bool) in
            let hide = true
            let animated = true
            self?.logLabel.text = "Did Tap Right Button. \n<Index: \(chosenIndex)> \n<chosenItem: \(chosenItem)> \n<Hide: \(hide)> \n<Animated: \(animated)>"
            print(self?.logLabel.text ?? "")
            return (hide, animated)
        })
        view.setDidScrollHandler({ [weak self] (view, chosenIndex, chosenItem) -> (shouldHide: Bool, animated: Bool) in
            let hide = false
            let animated = false
            self?.logLabel.text = "Did Scroll. \n<Index: \(chosenIndex)> \n<chosenItem: \(chosenItem)> \n<Hide: \(hide)> \n<Animated: \(animated)>"
            print(self?.logLabel.text ?? "")
            return (hide, animated)
        })
        view.setWillShowHandler({ [weak self] (view) in
            self?.showStatus.text = "View Will Show"
            print(self?.showStatus.text ?? "")
        })
        view.setDidShowHandler({ [weak self] (view) in
            self?.showStatus.text = "View Did Show"
            print(self?.showStatus.text ?? "")
        })
        view.setWillHideHandler({ [weak self] (view) in
            self?.showStatus.text = "View Will Hide"
            print(self?.showStatus.text ?? "")
        })
        view.setDidHideHandler({ [weak self] (view) in
            self?.showStatus.text = "View Did Hide"
            print(self?.showStatus.text ?? "")
        })
        return view
    }()
}

