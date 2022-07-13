import UIKit

class ViewController: UIViewController {

    var newPassword = ""
    var bruteForce = BruteForce(passwordToUnlock: "")
    var isStarted = false
    let queue = OperationQueue()
    let allowedCharacters = AllowedCharacters.array

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var emojiButton: UIButton!

    @IBOutlet weak var passwordLabel: UILabel!

    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func startButton(_ sender: Any) {

        isStarted.toggle()
        if bruteForce.isExecuting {
            bruteForce.cancel()
            return
        }
//       newPassword = generatePassword()

//        passwordLabel.text = "●●●"
//        passwordTextField.isSecureTextEntry = true
//      passwordTextField.text = newPassword
        newPassword = passwordTextField.text ?? ""
        bruteForce = BruteForce(passwordToUnlock: newPassword)
        bruteForce.delegate = self
        queue.addOperation(bruteForce)
        activityIndicator.startAnimating()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""

        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }

        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        // make sure the result is under 16 characters
        return updatedText.count <= 3
    }

    @IBAction func emojiButton(_ sender: Any) {
        emojiButton.setTitle(generateEmoji(), for: .normal)
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.text = newPassword
    }


    func showPasswordLabel(_ password: String) {
        passwordLabel.text = password
    }

    func showTextFieldPassword() {
        passwordTextField.isSecureTextEntry = false
    }

    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }

    func generateEmoji() -> String {
        return String(UnicodeScalar(Array(0x1F300...0x1F3F0).randomElement()!)!)
    }

    func generatePassword() -> String {
        var password = String()
        for _ in 1...3 {
            let character = allowedCharacters[Int.random(in: 0...allowedCharacters.count - 1)]
            password += character
        }
        return password
    }
}

protocol ShowPasswordProtocol {
    func showPasswordLabel(_ password: String)
    func showTextFieldPassword()
    func stopActivityIndicator()
}

extension ViewController: ShowPasswordProtocol {}
