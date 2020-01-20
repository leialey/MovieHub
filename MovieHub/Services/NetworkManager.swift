//
//  NetworkStatus.swift
//  MovieHub
//
//  Created by Leialey on 11.01.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation
import Network


public final class NetworkManager {
    
    public static let shared = NetworkManager()
    private var monitor: NWPathMonitor?
    private let concurrentQueue = DispatchQueue(label: "networkQueue", attributes: .concurrent)
    
    private init() {
    }
    
    
    func startMonitoring() {
        concurrentQueue.async(flags: .barrier) {
            guard self.monitor == nil else { return }
            self.monitor = NWPathMonitor()
            let queue = DispatchQueue(label: "NetStatusMonitor")
            self.monitor?.pathUpdateHandler = { _ in
                if self.monitor?.currentPath.status == .satisfied {
                    NotificationCenter.default.post(name: .connected, object: nil)
                }
            }
            self.monitor?.start(queue: queue)
        }
    }
    
    func stopMonitoring() {
        concurrentQueue.async(flags: .barrier) {
            guard self.monitor != nil else { return }
            self.monitor!.cancel()
            self.monitor = nil
        }
    }
    
    deinit {
        stopMonitoring()
    }
}
