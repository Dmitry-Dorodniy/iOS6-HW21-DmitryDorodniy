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

    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}

enum Metric {
    static let characterLimit: Int = 3
}
