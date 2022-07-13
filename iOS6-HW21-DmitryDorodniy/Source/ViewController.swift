import UIKit

class ViewController: UIViewController {

    var isStarted = false
    let queue = OperationQueue()
   let allowedCharacters = AllowedCharacters.array

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var button: UIButton!
    
    var isBlack: Bool = false {
        didSet {
            if isBlack {
                self.view.backgroundColor = .black
            } else {
                self.view.backgroundColor = .white
            }
        }
    }
    @IBOutlet weak var passwordLabel: UILabel!

    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func startButton(_ sender: Any) {

        newPassword = generatePassword()
        passwordLabel.text = "XXX"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.text = newPassword
        let bruteForce = BruteForce(passwordToUnlock: newPassword)
        bruteForce.delegate = self
        activityIndicator.startAnimating()
        queue.addOperation(bruteForce)
        
//            showPassword()


//        bruteForce.bruteForce()
//        bruteForce(passwordToUnlock: newPassword)

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


    @IBAction func onBut(_ sender: Any) {
        isBlack.toggle()
    }

    var newPassword = "1dr"
    
    override func viewDidLoad() {
        super.viewDidLoad()

//       newPassword = generatePassword()
        //bruteForce(passwordToUnlock: "1!gr")
        passwordTextField.text = newPassword

    }

    func generatePassword() -> String {
        var password = String()
        for _ in 1...3 {
            let character = allowedCharacters[Int.random(in: 0...allowedCharacters.count - 1)]
            password += character
        }
        return password
    }

//    func bruteForce(passwordToUnlock: String) {
//        //        let ALLOWED_CHARACTERS:[String] = String().printable.map { String($0) }
//
//        var password: String = ""
//
//        // Will strangely ends at 0000 instead of ~~~
//        while password != passwordToUnlock { // Increase MAXIMUM_PASSWORD_SIZE value for more
//            password = generateBruteForce(password, fromArray: allowedCharacters)
//            //             Your stuff here
//            print("\(password) ____ \(newPassword)")
//            // Your stuff here
//        }
//
//        print(password)
//    }
}

//extension String {
//    var digits:      String { return "0123456789" }
//    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
//    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
//    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
//    var letters:     String { return lowercase + uppercase }
//    var printable:   String { return digits + letters + punctuation }
//
//
//
//    mutating func replace(at index: Int, with character: Character) {
//        var stringArray = Array(self)
//        stringArray[index] = character
//        self = String(stringArray)
//    }
//}

//func indexOf(character: Character, _ array: [String]) -> Int {
//    return array.firstIndex(of: String(character))!
//}
//
//func characterAt(index: Int, _ array: [String]) -> Character {
//    return index < array.count ? Character(array[index])
//    : Character("")
//}
//
//func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
//    var str: String = string
//
//    if str.count <= 0 {
//        str.append(characterAt(index: 0, array))
//    }
//    else {
//        str.replace(at: str.count - 1,
//                    with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))
//
//        if indexOf(character: str.last!, array) == 0 {
//            str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
//        }
//    }
//
//    return str
//}
//

protocol ShowPasswordProtocol {
    func showPasswordLabel(_ password: String)
    func showTextFieldPassword()
    func stopActivityIndicator()
}

extension ViewController: ShowPasswordProtocol {}
