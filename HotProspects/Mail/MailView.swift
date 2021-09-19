//
//  MailView.swift
//  HotProspects
//
//  Created by Chad Smith on 9/19/21.
//

import MessageUI
import SwiftUI

typealias MailViewCallback = ((Result<MFMailComposeResult, Error>) -> Void)?

struct MailView : UIViewControllerRepresentable {
    static var canSendMail: Bool {
        MFMailComposeViewController.canSendMail()
    }
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var data: MailComposeData
    let callback: MailViewCallback
    
    class Coordinator : NSObject, MFMailComposeViewControllerDelegate {
        @Binding var presentationMode: PresentationMode
        @Binding var data: MailComposeData
        let callback: MailViewCallback
        
        init(presentationMode: Binding<PresentationMode>, data: Binding<MailComposeData>, callback: MailViewCallback) {
            self._presentationMode = presentationMode
            self._data = data
            self.callback = callback
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            if let error = error {
                callback?(.failure(error))
            } else {
                callback?(.success(result))
            }
            
            $presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(presentationMode: presentationMode, data: $data, callback: callback)
    }
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailController = MFMailComposeViewController()
        mailController.mailComposeDelegate = context.coordinator
        mailController.setSubject(data.subject)
        mailController.setToRecipients(data.recipients)
        mailController.setMessageBody(data.message, isHTML: data.isHtml)
        
        data.attachments?.forEach({ attachment in
            mailController.addAttachmentData(attachment.data, mimeType: attachment.mimeType, fileName: attachment.fileName)
        })
        
        mailController.accessibilityElementDidLoseFocus()
        
        return mailController
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) { }
}
