import UIKit

class ViewController: UIViewController {

    var newPassword = ""
    var bruteForce = BruteForce(passwordToUnlock: "")
    let queue = OperationQueue()
    let allowedCharacters = AllowedCharacters.array

    // MARK: - Set UI elements

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var emojiButton: UIButton!

    @IBOutlet weak var passwordLabel: UILabel!

    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func startButton(_ sender: Any) {
        guard !bruteForce.isExecuting else { bruteForce.cancel()
            return }
//      newPassword = generatePassword()
//      passwordTextField.text = newPassword

        newPassword = passwordTextField.text ?? ""
        guard checkPassword(newPassword) else {
            alert(with: newPassword)
            return
        }
        bruteForce = BruteForce(passwordToUnlock: newPassword)
        bruteForce.delegate = self
        queue.addOperation(bruteForce)
        activityIndicator.startAnimating()
    }

    @IBAction func emojiButton(_ sender: Any) {
        emojiButton.setTitle(generateEmoji(), for: .normal)
    }

    func checkPassword(_ text: String) -> Bool {
        return text.containsValidCharacter
    }

    func alert(with newPassword: String) {
        let alert = UIAlertController(title: "\(newPassword) - incorrect", message: "INPUT ONLY: \(String().printable)", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: { self.passwordTextField.text = "" })
    }

    func generateEmoji() -> String {
        return String(UnicodeScalar(Array(0x1F300...0x1F3F0).randomElement()!)!)
    }

//    Generate password
    func generatePassword() -> String {
        var password = String()
        for _ in 1...Metric.characterLimit {
            let character = allowedCharacters[Int.random(in: 0...allowedCharacters.count - 1)]
            password += character
        }
        return password
    }
}

// MARK: - Brut force delegate function
protocol ShowPasswordProtocol {
    func showPasswordLabel(_ password: String)
    func showTextFieldPassword()
    func stopActivityIndicator()
}

extension ViewController: ShowPasswordProtocol {

    func showPasswordLabel(_ password: String) {
        passwordLabel.text = password
    }

    func showTextFieldPassword() {
        passwordTextField.isSecureTextEntry = false
    }

    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}

// MARK: - TextField Delegate - limitation of text characters
extension ViewController: UITextFieldDelegate {
    private func textLimit(existingText: String?,
                           newText: String,
                           limit: Int) -> Bool {
        let text = existingText ?? ""
        let isAtLimit = text.count + newText.count <= limit
        return isAtLimit
    }

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        textField.isSecureTextEntry = true
        return self.textLimit(existingText: textField.text,
                              newText: string,
                              limit: Metric.characterLimit)
    }

    
}
