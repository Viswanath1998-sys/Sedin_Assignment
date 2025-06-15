//
//  Untitled.swift
//  Sedin_Assignment
//
//  Created by Viswanath M on 15/06/25.
//

import SwiftUI
import Network
import Combine

class NetworkMonitor: ObservableObject {
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    
    @Published private(set) var isConnected: Bool = false
    
    init() {
        
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                let status = path.status == .satisfied
             
                print("Network Status changed to \(status ? "Connected" : "Disconnected")")
                self?.isConnected = status
            }
        }
        
        monitor.start(queue: queue)
    }
    
    deinit {
        print("De intited")
        monitor.cancel()
    }
}
