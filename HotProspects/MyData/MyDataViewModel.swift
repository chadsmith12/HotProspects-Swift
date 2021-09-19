//
//  MyDataViewModel.swift
//  HotProspects
//
//  Created by Chad Smith on 9/18/21.
//

import Foundation

class MyDataViewModel : ObservableObject {
    @Published var name: String
    @Published var email: String
    
    init() {
        name = "Anonymous"
        email = "you@yoursite.com"
    }
    
    var qrData: String {
        "\(name)\n\(email)"
    }
}
