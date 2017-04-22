
import UIKit

typealias CustomView = ELCustomPickerView<(key: String, content: String)>

class ViewController: UIViewController {
    @IBOutlet weak var logLabel: UILabel!
    @IBAction func didTapShowButton(_ sender: Any) {
        customPickerView.show(viewController: nil, animated: true)
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

