import UIKit

class ViewController: UIViewController {

    // Create a UITextView
    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.isEditable = true
        textView.text = "Enter your text here"
        textView.textColor = .gray
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add the UITextView to the view
        view.addSubview(textView)

        // Add constraints to the UITextView
        textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 150).isActive = true

        // Create a UIButton
        let copyButton = UIButton(type: .system)
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        copyButton.setTitle("Copy", for: .normal)
        copyButton.addTarget(self, action: #selector(copyButtonTapped), for: .touchUpInside)

        // Add the UIButton to the view
        view.addSubview(copyButton)

        // Add constraints to the UIButton
        copyButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20).isActive = true
        copyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    @objc func copyButtonTapped() {
        // Copy the contents of the UITextView to the clipboard
        UIPasteboard.general.string = textView.attributedText.string
    }
}
