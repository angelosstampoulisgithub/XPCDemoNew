//
//  XPCDemoNewApp.swift
//  XPCDemoNew
//
//  Created by Angelos Staboulis on 18/1/25.
//

import SwiftUI

@main
struct XPCDemoNewApp: App {
    var connectionManager = ConnectionManager()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(connectionManager)
        }
    }
}
