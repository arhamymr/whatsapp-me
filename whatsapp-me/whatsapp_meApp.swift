//
//  whatsapp_meApp.swift
//  whatsapp-me
//
//  Created by arham on 03/12/23.
//

import SwiftUI

@main
struct whatsapp_meApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(PersistentController.shared)
        }
    }
}
