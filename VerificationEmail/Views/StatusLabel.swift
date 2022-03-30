//
//  StatusLabel.swift
//  VerificationEmail
//
//  Created by Alexander Avdacev on 28.03.22.
//

import UIKit

class StatusLabel: UILabel {

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
        text = "Check your mail"
        textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        font = UIFont(name: "Apple SD Gothic Neo", size: 16)
        adjustsFontSizeToFitWidth = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setNotValidSetting() {
        text = "Mail is not valid. Example: name@domain.ru"
        textColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
    }
    
    func setValidSetting() {
        text = "Mail is valid"
        textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
    }
    
    func setDefaultSetting() {
        configure()
    }
}
