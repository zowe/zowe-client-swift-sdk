//
//  ZOSConnection.swift
//  Zowe SDK
//
//  This program and the accompanying materials are made available under the terms of the
//  Eclipse Public License v2.0 which accompanies this distribution, and is available at
//  https://www.eclipse.org/legal/epl-v20.html
//  SPDX-License-Identifier: EPL-2.0
//
//  Copyright © 2020 Contributors to the Zowe Project. All rights reserved.
//

import Foundation

/// z/OS REST API connection struct
internal struct ZOSConnection {
    
    // MARK: - ZOSConnection internal members
    
    /// The z/OS REST API host address
    internal let host: String
    
    /// The z/OS REST API host port
    internal let port: String?
    
    /// The mainframe Id for the z/OS REST API
    internal let user: String
    
    /// The password for the z/OS REST API
    internal let password: String
    
    /// ZOSConnection object constructor with z/OSMF host, port and credentials
    /// - Parameters:
    ///   - host: The host for the z/OSMF REST API
    ///   - port: The port for the z/OSMF REST API (nil by default)
    ///   - user: The user for the z/OSMF REST API
    ///   - password: The password for the z/OSMF REST API
    internal init(host: String, port: String? = nil, user: String, password: String) {
        var hostWithoutScheme: String?
        if let scheme = URL(string: host)?.scheme?.appending("://") {
            hostWithoutScheme = host.replacingOccurrences(of: scheme, with: "")
        }
        
        self.host = hostWithoutScheme ?? host
        self.port = port
        self.user = user
        self.password = password
    }
}
