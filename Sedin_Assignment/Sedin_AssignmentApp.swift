//
//  Sedin_AssignmentApp.swift
//  Sedin_Assignment
//
//  Created by Viswanath M on 15/06/25.
//

import SwiftUI

@main
struct Sedin_AssignmentApp: App {
    @StateObject var networkMonitor = NetworkMonitor()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(networkMonitor)
        }
    }
}
