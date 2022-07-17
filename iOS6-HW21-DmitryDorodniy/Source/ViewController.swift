import UIKit

class ViewController: UIViewController {

    var newPassword = ""
    var bruteForce = BruteForceOperation(passwordToUnlock: "")
    let queue = OperationQueue()
    var isEyeOpen = false

    // MARK: - Set UI elements

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emojiButton: UIButton!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var eyeButton: UIButton!
    @IBAction func securePasswordEyeButton() {
        toggleTextFieldPasswordSecurity()
    }

    @IBAction func startButton(_ sender: Any) {
        startHacking()
    }

    @IBAction func emojiButton(_ sender: Any) {
        emojiButton.setTitle(String.generateEmoji(), for: .normal)
    }

    // MARK: - Functions

    func startHacking() {
        guard !bruteForce.isExecuting else {
            bruteForce.cancel()
            return }
        //      newPassword = String.generatePassword()
        //      passwordTextField.text = newPassword
        newPassword = passwordTextField.text ?? ""
        guard checkPassword(newPassword) else {
            alert(with: newPassword)
            return
        }
        bruteForce = BruteForceOperation(passwordToUnlock: newPassword)
        bruteForce.delegate = self
        queue.addOperation(bruteForce)
        activityIndicator.startAnimating()
    }

    func showTextFieldPassword() {
        isEyeOpen = false
        toggleTextFieldPasswordSecurity()
    }

    func toggleTextFieldPasswordSecurity() {
        if !isEyeOpen {
            eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
            passwordTextField.isSecureTextEntry = false
        } else {
            eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            passwordTextField.isSecureTextEntry = true
        }
        isEyeOpen.toggle()
    }

    // check and alert for not allowed character --not used--
    // use textField delegate that not allowing to input unallowed characters instead
    func checkPassword(_ text: String) -> Bool {
        return text.containsValidCharacter
    }

    func alert(with newPassword: String) {
        let alert = UIAlertController(title: "\(newPassword) - incorrect",
                                      message: "INPUT ONLY: \(String().printable)",
                                      preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK",
                                     style: .destructive,
                                     handler: nil)
        alert.addAction(okButton)
        //вариант с захватом слабой ссылки на ViewController
//        present(alert, animated: true,
//                completion: { [weak self] in
//                self?.passwordTextField.text = "" })
        //вариант с хахватом только нужного элемента
        present(alert, animated: true,
                completion: { [passwordTextField] in
                passwordTextField?.text = "" })

    }
}

// MARK: - Brut force delegate functions
extension ViewController: ShowPasswordProtocol {

    func showPasswordLabel(_ password: String) {
        passwordLabel.text = password
    }

    func successHacking() {
        activityIndicator.stopAnimating()
        showTextFieldPassword()
        emojiButton.setTitle(Constants.successEmoji, for: .normal)
    }

    func cancelHacking() {
        activityIndicator.stopAnimating()
        passwordLabel.text = Constants.cancelLabel
        emojiButton.setTitle(Constants.cancelEmoji, for: .normal)
    }
}

// MARK: - TextField Delegate - limitation of text characters, guard allowed symbols, keyboard action
extension ViewController: UITextFieldDelegate {
    private func textLimit(existingText: String?,
                           newText: String,
                           limit: Int) -> Bool {
        let text = existingText ?? ""
        let isAtLimit = (text.count + newText.count <= limit)
        && (text + newText).containsValidCharacter
        //        check for character limit and input allowed symbols
        return isAtLimit
    }

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        return self.textLimit(existingText: textField.text,
                              newText: string,
                              limit: Constants.characterLimit)
    }

    //action by keyboard Return pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        startHacking()
        return true
    }
}
