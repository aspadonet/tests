//
//  MainCollectionView.swift
//  VerificationEmail
//
//  Created by Alexander Avdacev on 28.03.22.
//

import UIKit

protocol SelectProposedMailProtocol: AnyObject {
    func selectProposedMail(indexPath: IndexPath)
}

enum IdCell: String {
    case idEmailCell
}

class MainCollectionView: UICollectionView  {
    
    weak var selectEmailDelegate: SelectProposedMailProtocol?

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        register(EmailCollectionViewCell.self, forCellWithReuseIdentifier: IdCell.idEmailCell.rawValue)
        self.delegate = self
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .none
}
}

extension MainCollectionView: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectEmailDelegate?.selectProposedMail(indexPath: indexPath)
    }
}

extension MainCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 2 - 5, height: 40)
    }
}


