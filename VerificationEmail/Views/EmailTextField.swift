//
//  EmailTextField.swift
//  VerificationEmail
//
//  Created by Alexander Avdacev on 28.03.22.
//

import Foundation
import UIKit

protocol ActionsEmailTextFieldProtocol: AnyObject {
    func typingText(text: String)
    func cleanOutTextField()
}

class EmailTextField: UITextField {
    
    weak var textFieldDelegate: ActionsEmailTextFieldProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        backgroundColor = .white
        borderStyle = .none
        layer.cornerRadius = 10
        textColor = #colorLiteral(red: 0.2156862745, green: 0.2156862745, blue: 0.2156862745, alpha: 1)
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        leftViewMode = .always
        clearButtonMode = .always
        returnKeyType = .done
        placeholder = "Enter email"
        font = UIFont(name: "Apple SD Gothic Neo", size: 20)
        tintColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}

extension EmailTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text, let rangeText = Range(range, in: text) {
            let updateText = text.replacingCharacters(in: rangeText, with: string)
            textFieldDelegate?.typingText(text: updateText)
        }
        
        
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textFieldDelegate?.cleanOutTextField()
        return true
    }
}
