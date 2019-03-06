//
//  ReachabilityService.swift
//  MoviesSwift
//
//  Created by João Fontana on 06/03/19.
//  Copyright © 2019 fontana. All rights reserved.
//

import Foundation
import Reachability

final class ReachabiltyService {
    private let reachability: Reachability

    static let shared = ReachabiltyService()

    private init() {
        self.reachability = Reachability()!

        self.reachability.whenReachable = { _ in
            print("Internet connected")
            NotificationCenter.default.post(name: .InternetConnected, object: nil)
        }

        self.reachability.whenUnreachable = { _ in
            print("Internet disconnected")
            NotificationCenter.default.post(name: .InternetDisconnected, object: nil)
        }

        do {
            try self.reachability.startNotifier()
        } catch {
            print("Failed to start Reachability")
        }
    }

    func isConnected() -> Bool {
        switch reachability.connection {
        case .none:
            return false
        case .wifi, .cellular:
            return true

        }
    }
}


