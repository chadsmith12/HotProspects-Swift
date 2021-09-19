//
//  QRCodeGenerator.swift
//  HotProspects
//
//  Created by Chad Smith on 9/18/21.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct QRCodeGenerator {
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    
    func generate(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.message = data
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
