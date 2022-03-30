//
//  VerificationModel.swift
//  VerificationEmail
//
//  Created by Alexander Avdacev on 29.03.22.
//

import Foundation

class VerificationModel {
    
    let mailsArray = ["@gmail.com", "@yandex.ru", "@yahoo.com"]
    var nameMail = String()
    var filtredMailArray = [String]()
    
    func filtringMails(text: String) {
        
        var domainMail = String()
        filtredMailArray = []
        
        guard let firstIndex = text.firstIndex(of: "@") else {
            return
        }
        
        let endIndex = text.index(before: text.endIndex)
        let range = text[firstIndex...endIndex]
        domainMail = String(range)
        
        mailsArray.forEach{ mail in
            if mail.contains(domainMail){
                if !filtredMailArray.contains(mail){
                    filtredMailArray.append(mail)
                }
            }
        }
        
    }
    
    func deriveNameMail(text: String) {
        guard let atSymbolIndex = text.firstIndex(of: "@") else {
            return
        }
        let endIndex = text.index(before: atSymbolIndex)
        let firstIndex = text.startIndex
        let range = text[firstIndex...endIndex]
        nameMail = String(range)
    }
    
    func getFiltredMail(text: String) {
        filtringMails(text: text)
    }
    func getMailName(text: String) {
        deriveNameMail(text: text)
    }
}
