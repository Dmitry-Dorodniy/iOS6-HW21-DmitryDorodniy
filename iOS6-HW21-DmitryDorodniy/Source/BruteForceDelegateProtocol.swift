//
//  BruteForceDelegateProtocol.swift
//  iOS6-HW21-DmitryDorodniy
//
//  Created by Dmitry Dorodniy on 17.07.2022.
//

protocol ShowPasswordProtocol {
    /// Show password on label
    /// - Parameter password: inputed password
    func showPasswordLabel(_ password: String)
    /// Actions if password search was success
    func successHacking()
    /// Actions if user taped cancel
    func cancelHacking()
}
