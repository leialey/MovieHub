//
//  NetworkStatus.swift
//  MovieHub
//
//  Created by Leialey on 11.01.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation
import Network

class NetworkManager {
    
    static let shared = NetworkManager()
    private var monitor: NWPathMonitor?
    var onConnected: (()->())?
    
    private init() {
    }
    
    func startMonitoring() {
        guard monitor == nil else { return }
        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetStatusMonitor")
        monitor?.pathUpdateHandler = { _ in
            if self.monitor?.currentPath.status == .satisfied {
                self.onConnected?()
            }
        }
        monitor?.start(queue: queue)
    }
    
    func stopMonitoring() {
        guard monitor != nil else { return }
        monitor!.cancel()
        monitor = nil
    }
    
    deinit {
        stopMonitoring()
    }
}
