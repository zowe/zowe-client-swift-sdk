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

/// Primary class for Zowe Client Swift SDK
public class ZoweSDK {
    
    // MARK: - ZoweSDK private members
    
    /// z/OS REST API connection object
    private let connection: ZOSConnection
    
    // MARK: - ZoweSDK public members
    
    /// z/OS Console REST API object
    //public let console: ZOSConsole
    
    /// z/OS Files REST API class
    public let files: ZOSFiles
    
    /// z/OS Jobs REST API class
    public let jobs: ZOSJobs
    
    /// z/OS TSO REST API class
    //public let tso: ZOSTso
    
    /// z/OSMF REST API information retrieval service object
    public let zosmf: Zosmf
    
    // MARK: - ZoweSDK constructors
    
    /// ZoweSDK object private constructor
    /// - Parameter connection: z/OS REST API connection object
    private init(
        _ connection: ZOSConnection
    ) {
        self.connection = connection
        //console = ZOSConsole(connection)
        files = ZOSFiles(connection)
        jobs = ZOSJobs(connection)
        //tso = ZOSTso(connection)
        zosmf = Zosmf(connection)
    }
    
    /// ZoweSDK object convenience constructor with Zowe host address and credentials
    /// - Parameters:
    ///   - zosmfHost: The z/OSMF host address (nil by default)
    ///   - zosmfUser: The user for the z/OSMF REST API (nil by default)
    ///   - zosmfPassword: The password for the z/OSMF REST API (nil by default)
    public convenience init(
        zosmfHost: String,
        zosmfUser: String,
        zosmfPassword: String
    ) {
        let connection = ZOSConnection(
            zosmfHost: zosmfHost,
            zosmfUser: zosmfUser,
            zosmfPassword: zosmfPassword
        )
        self.init(connection)
    }
    
    /// ZoweSDK object convenience constructor with Zowe profile
    /// - Parameters:
    ///   - zosmfProfile: The Zowe z/OSMF profile name in case it already exists (nil by default)
    public convenience init(
        zosmfProfile: String
    ) {
        let connection = ZosmfProfile(
            profileName: zosmfProfile
        ).load()
        self.init(connection)
    }
}
