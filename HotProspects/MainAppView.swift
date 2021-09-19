//
//  MainAppView.swift
//  HotProspects
//
//  Created by Chad Smith on 9/16/21.
//

import SwiftUI

struct MainAppView: View {
    var body: some View {
        TabView {
            ProspectsView()
                .tabItem {
                    ProspectTabItem(label: "Everyone", systemName: "person.3")
                }
//            ProspectsView(filterType: .contacted)
//                .tabItem {
//                    ProspectTabItem(label: "Contacted", systemName: "checkmark.circle")
//                }
//            ProspectsView(filterType: .uncontacted)
//                .tabItem {
//                    ProspectTabItem(label: "Uncontacted", systemName: "questionmark.diamond")
//                }
            MeView()
                .tabItem {
                    ProspectTabItem(label: "Me", systemName: "person.crop.square")
                }
        }
    }
}

struct MainAppView_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView()
            .environmentObject(ProspectsStore())
    }
}
