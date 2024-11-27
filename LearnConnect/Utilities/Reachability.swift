//
//  Reachability.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 27.11.2024.
//

import SystemConfiguration

class Reachability {
    
    enum Connection {
        case wifi
        case cellular
        case unavailable
    }

    static func currentConnection() -> Connection {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return .unavailable
        }

        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .unavailable
        }

        return determineConnectionType(flags: flags)
    }
    
    private static func determineConnectionType(flags: SCNetworkReachabilityFlags) -> Connection {
        if !flags.contains(.reachable) {
            return .unavailable
        }

        if flags.contains(.isWWAN) {
            return .cellular
        }

        if !flags.contains(.connectionRequired) {
            return .wifi
        }

        return .unavailable
    }
}

