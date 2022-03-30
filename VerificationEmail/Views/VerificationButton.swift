//
//  VerificationButton.swift
//  VerificationEmail
//
//  Created by Alexander Avdacev on 28.03.22.
//

import Foundation
import UIKit

class VerificationButton: UIButton {
    
    var isValid = false {
        didSet {
            if self.isValid {
                setValidSetting()
            } else {
                setNotValidSetting()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure() {
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setTitle("Verification Button", for: .normal)
        let color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        setTitleColor(color, for: .normal)
        layer.cornerRadius = 10
        titleLabel?.font = UIFont(name: "Avenir Book", size: 17)
        isEnabled = false
        alpha = 0.5
        translatesAutoresizingMaskIntoConstraints = false
    }
    func setNotValidSetting() {
        isEnabled = false
        alpha = 0.5
    }
    
    func setValidSetting() {
        isEnabled = true
        alpha = 1
    }
    
    func setDefaultSetting() {
        configure()
    }
}
