//
//  MailData.swift
//  HotProspects
//
//  Created by Chad Smith on 9/19/21.
//

import Foundation

struct MailComposeData {
    let subject: String
    let recipients: [String]?
    let message: String
    let attachments: [AttachmentData]?
    let isHtml: Bool = false
}

struct AttachmentData {
    let data: Data
    let mimeType: String
    let fileName: String
}
