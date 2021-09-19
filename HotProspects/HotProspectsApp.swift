//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Chad Smith on 9/16/21.
//

import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            MainAppView()
                .environmentObject(ProspectsStore())
        }
    }
}
