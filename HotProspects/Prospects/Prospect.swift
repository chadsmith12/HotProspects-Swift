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
}
