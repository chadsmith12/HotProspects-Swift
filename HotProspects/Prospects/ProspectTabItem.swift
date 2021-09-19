//
//  ProspectTabItem.swift
//  HotProspects
//
//  Created by Chad Smith on 9/17/21.
//

import SwiftUI

struct ProspectTabItem: View {
    var label: String
    var systemName: String
    
    var body: some View {
        Image(systemName: systemName)
        Text(label)
    }
}

struct ProspectTabItem_Previews: PreviewProvider {
    static var previews: some View {
        ProspectTabItem(label: "Everyone", systemName: "person.3")
    }
}
