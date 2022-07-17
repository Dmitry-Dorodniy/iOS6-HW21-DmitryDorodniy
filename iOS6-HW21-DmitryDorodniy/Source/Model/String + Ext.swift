//
//  AllowedCharacters.swift
//  iOS6-HW21-DmitryDorodniy
//
//  Created by Dmitry Dorodniy on 11.07.2022.
//

import Foundation

struct AllowedCharacters {
    static let array: [String] = String().printable.map { String($0) }
}

extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }

    var containsValidCharacter: Bool {
        guard self != "" else { return true }
        let printableSet = CharacterSet(charactersIn: printable)
        let newSet = CharacterSet(charactersIn: self)
        return printableSet.isSuperset(of: newSet)
    }

    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}

extension String {
    /// Random emoji generator
    /// - Returns: return String with one emoji
    static func generateEmoji() -> String {
        return String(UnicodeScalar(Array(0x1F300...0x1F3F0).randomElement()!)!)
    }

    //    generate password -- not used --
    //    created fot 1st version, not implemented here
    static func generatePassword() -> String {
        var password = String()
        for _ in 1...Constants.characterLimit {
            let character = AllowedCharacters.array[Int.random(in: 0...AllowedCharacters.array.count - 1)]
            password += character
        }
        return password
    }

}
