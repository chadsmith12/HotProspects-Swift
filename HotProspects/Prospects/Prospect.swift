//
//  Prospect.swift
//  HotProspects
//
//  Created by Chad Smith on 9/18/21.
//

import Foundation

struct Prospect : Identifiable, Codable {
    var id = UUID()
    let name: String
    let email: String
    var isContacted: Bool
    
    mutating func toggleContacted() {
        self.isContacted.toggle()
    }
    
    var mailData: MailComposeData {
        let subject = "Hello \(self.name)"
        let recipient = [self.email]
        
        return MailComposeData(subject: subject, recipients: recipient, message: "", attachments: nil)
    }
}
