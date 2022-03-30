//
//  EmailCollectionViewCell.swift
//  VerificationEmail
//
//  Created by Alexander Avdacev on 28.03.22.
//

import Foundation
import UIKit

class EmailCollectionViewCell: UICollectionViewCell {
   
    
    let domainLabel: UILabel = {
       let label = UILabel()
        label.text = "gmail.com"
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView() {
        contentView.backgroundColor = .white
        contentView.alpha = 0.5
        contentView.layer.cornerRadius = 10
        
        addSubview(domainLabel)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            domainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            domainLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configure(mailLabelText: String) {
        domainLabel.text = mailLabelText
    }
    
    func cellConfigure(mailLabelText: String){
        configure(mailLabelText: mailLabelText)
    }
}
