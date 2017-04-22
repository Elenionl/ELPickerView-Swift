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

    @IBAction func showByWindow(_ sender: UIButton) {
        customPickerView.title.text = "Show by Window"
        customPickerView.blackBackground = true
        customPickerView.isTitleBarHidden = false
        customPickerView.foregroundView.bottomDivider.isHidden = false
        customPickerView.foregroundView.bottomDivider.isHidden = false
        customPickerView.show(viewController: nil, animated: true)
    }
    @IBAction func showByViewController(_ sender: UIButton) {
        customPickerView.title.text = "Show by ViewController"
        customPickerView.blackBackground = true
        customPickerView.isTitleBarHidden = false
        customPickerView.foregroundView.bottomDivider.isHidden = false
        customPickerView.foregroundView.bottomDivider.isHidden = false
        customPickerView.show(viewController: self, animated: true)
    }
    @IBAction func showWithWhiteBackground(_ sender: UIButton) {
        customPickerView.title.text = "Show With White Background"
        customPickerView.blackBackground = false
        customPickerView.isTitleBarHidden = false
        customPickerView.foregroundView.bottomDivider.isHidden = false
        customPickerView.foregroundView.bottomDivider.isHidden = false
        customPickerView.show(viewController: self, animated: true)
    }
    @IBAction func showWithoutTitleBar(_ sender: UIButton) {
        customPickerView.title.text = "Show With White Background"
        customPickerView.blackBackground = true
        customPickerView.isTitleBarHidden = true
        customPickerView.foregroundView.bottomDivider.isHidden = false
        customPickerView.foregroundView.bottomDivider.isHidden = false
        customPickerView.show(viewController: self, animated: true)
    }
    @IBAction func showWithNoDivider(_ sender: UIButton) {
        customPickerView.title.text = "Show With No Divider"
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
        view.itemConfigHandler = { (key: String, content: String) in
            return content
        }
        view.leftButtoTapHandler = { [weak self] (view: CustomView?, chosenIndex: Int, chosenItem: (key: String, content: String)) in
            let hide = true
            let animated = true
            self?.logLabel.text = "Did Tap Left Button. <Index: \(chosenIndex)> <chosenItem: \(chosenItem)> <Hide: \(hide)> <Animated: \(animated)>"
            print(self?.logLabel.text ?? "")
            return (hide, animated)
        }
        view.rightButtoTapHandler = { [weak self] (view: CustomView?, chosenIndex: Int, chosenItem: (key: String, content: String)) in
            let hide = true
            let animated = true
            self?.logLabel.text = "Did Tap Right Button. <Index: \(chosenIndex)> <chosenItem: \(chosenItem)> <Hide: \(hide)> <Animated: \(animated)>"
            print(self?.logLabel.text ?? "")
            return (hide, animated)
        }
        view.didScrollHandler = { [weak self] (view: CustomView?, chosenIndex: Int, chosenItem: (key: String, content: String)) in
            let hide = false
            let animated = false
            self?.logLabel.text = "Did Scroll. <Index: \(chosenIndex)> <chosenItem: \(chosenItem)> <Hide: \(hide)> <Animated: \(animated)>"
            print(self?.logLabel.text ?? "")
            return (hide, animated)
        }
        view.willShowHandler = { [weak self] (view: CustomView?) in
            self?.logLabel.text = "View Will Show"
            print(self?.logLabel.text ?? "")
        }
        view.didShowHandler = { [weak self] (view: CustomView?) in
            self?.logLabel.text = "View Did Show"
            print(self?.logLabel.text ?? "")
        }
        view.willHideHandler = { [weak self] (view: CustomView?) in
            self?.logLabel.text = "View Will Hide"
            print(self?.logLabel.text ?? "")
        }
        view.didHideHandler = { [weak self] (view: CustomView?) in
            self?.logLabel.text = "View Did Hide"
            print(self?.logLabel.text ?? "")
        }
        return view
    }()
}

