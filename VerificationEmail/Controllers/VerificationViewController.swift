//
//  ViewController.swift
//  VerificationEmail
//
//  Created by Alexander Avdacev on 28.03.22.
//

import UIKit

class VerificationViewController: UIViewController, SelectProposedMailProtocol {
    
    func selectProposedMail(indexPath: IndexPath) {
        guard let text = emailTextField.text else {
            return
        }
        verificationModel.getMailName(text: text)
        let domainMail = verificationModel.filtredMailArray[indexPath.row]
        let mailFullName = verificationModel.nameMail + domainMail
        print(mailFullName)
        emailTextField.text = mailFullName
        statusLabel.isValid = mailFullName.isValid()
        verificationButton.isValid = mailFullName.isValid()
        verificationModel.filtredMailArray = []
        collextionView.reloadData()
    }
    

    let statusLabel = StatusLabel()
    let emailTextField = EmailTextField()
    let verificationButton = VerificationButton()
    let collextionView = MainCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    lazy var stackView = UIStackView(arrangedSubviews: [emailTextField, verificationButton, collextionView], axis: .vertical, spacing: 20)
    
    let verificationModel = VerificationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setDelegates()
        setConstraints()
        
        
    }
    
    func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.addSubview(statusLabel)
        view.addSubview(stackView)
        verificationButton.addTarget(self, action: #selector(verificationButtonTapped), for: .touchUpInside)
    }
    
    func setDelegates() {
        collextionView.dataSource = self
        collextionView.selectEmailDelegate = self
        emailTextField.textFieldDelegate = self
    }
    
    @objc func verificationButtonTapped() {
        guard let mail = emailTextField.text else {
            return
        }
        
        NetworkDataFetch.shared.fetchMail(verifiableMail: mail) { result, error in
            if error == nil {
                guard let result = result else {
                    return
                }
                if result.success {
                    guard let didYouMeanError = result.did_you_mean else {
                        Alert.showResultAlert(vc: self, message: "Mail Status \(result.result) \n \(result.reasonDescription)")
                        return
                    }
                    Alert.showErrorAlert(vc: self, message: "Did you mean \(didYouMeanError)") {
                        [weak self] in
                        guard let self = self else {return}
                        self.emailTextField.text = didYouMeanError
                    }
                }
            } else {
                guard let errorDescription = error?.localizedDescription else {
                    return
                }
                Alert.showResultAlert(vc: self, message: errorDescription)
            }
        }
        
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 4),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }

}

extension VerificationViewController: ActionsEmailTextFieldProtocol {
    func typingText(text: String) {
        statusLabel.isValid = text.isValid()
        verificationButton.isValid = text.isValid()
        verificationModel.getFiltredMail(text: text)
        collextionView.reloadData()
    }
    
    func cleanOutTextField() {
        statusLabel.setDefaultSetting()
        verificationButton.setDefaultSetting()
        verificationModel.filtredMailArray = []
        collextionView.reloadData()
    }
    
    
}

extension VerificationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        verificationModel.filtredMailArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IdCell.idEmailCell.rawValue, for: indexPath) as? EmailCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let mailLabelText = verificationModel.filtredMailArray[indexPath.row]
        cell.cellConfigure(mailLabelText: mailLabelText)
        
        return cell
    }
    
    
}
