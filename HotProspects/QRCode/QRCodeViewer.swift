//
//  QRCodeViewer.swift
//  HotProspects
//
//  Created by Chad Smith on 9/18/21.
//

import SwiftUI

struct QRCodeViewer: View {
    private let qrGenerator = QRCodeGenerator()
    
    var data: String
    var width: CGFloat = 200
    var height: CGFloat = 200
    
    var qrCode: UIImage {
        qrGenerator.generate(from: self.data)
    }
    
    var body: some View {
        Image(uiImage: qrCode)
            .resizable()
            .interpolation(.none)
            .scaledToFit()
            .frame(width: width, height: height)
    }
}

struct QRCodeViewer_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeViewer(data: "Hello")
    }
}
