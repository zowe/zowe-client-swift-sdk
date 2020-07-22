//
//  ZoweSDK.swift
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

/// Primary struct for Zowe Client Swift SDK
public struct ZoweSDK {
    
    // MARK: - ZoweSDK internal members
    
    /// z/OS REST API connection object
    internal let connection: ZOSConnection
    
    // MARK: - ZoweSDK constructors
    
    /// ZoweSDK object private constructor
    /// - Parameter connection: z/OS REST API connection object
    private init(
        _ connection: ZOSConnection
    ) {
        self.connection = connection
    }
    
    /// ZoweSDK object convenience constructor with z/OSMF host, port and credentials
    /// - Parameters:
    ///   - host: The host for the z/OSMF REST API
    ///   - port: The port for the z/OSMF REST API (nil by default)
    ///   - user: The user for the z/OSMF REST API
    ///   - password: The password for the z/OSMF REST API
    public init(
        host: String,
        port: String? = nil,
        user: String,
        password: String
    ) {
        let connection = ZOSConnection(
            host: host,
            port: port,
            user: user,
            password: password
        )
        self.init(connection)
    }
    
    /// ZoweSDK object convenience constructor with Zowe profile
    /// - Parameters:
    ///   - profileName: The Zowe profile name 
    public init(
        profileName: String
    ) {
        let connection = ZosmfProfile(
            profileName: profileName
        ).load()
        self.init(connection)
    }
}
