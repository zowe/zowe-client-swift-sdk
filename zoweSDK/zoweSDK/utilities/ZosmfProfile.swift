//
//  ZosmfProfile.swift
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

/// Zowe z/OSMF profile struct
internal struct ZosmfProfile {
    
    // MARK: - ZosmfProfile internal members
    
    /// Zowe z/OSMF profile's required fields
    internal enum RequiredFields: String, CaseIterable {
        case host, user, password
    }
    
    /// Zowe z/OSMF profile's optional fields
    internal enum OptionalFields: String, CaseIterable {
        case port
    }
    
    /// Zowe z/OSMF profile name
    internal let profileName: String
    
    // MARK: - ZosmfProfile internal methods
    
    /// Load z/OSMF connection details from Zowe z/OSMF profile
    /// - Returns: z/OSMF API connection object
    internal func load() -> ZosmfConnection {
        guard let profileYaml = UserDefaults.standard.dictionary(forKey: profileName) else {
            fatalError(ZosmfError.zoweProfile(name: profileName).errorDescription!)
        }
        
        guard var zosmfHost = profileYaml[RequiredFields.host.rawValue] as? String,
            let zosmfUser = profileYaml[RequiredFields.user.rawValue] as? String,
            let zosmfPassword = profileYaml[RequiredFields.password.rawValue] as? String else {
            let requiredFields = Set(RequiredFields.allCases.map( { $0.rawValue } ))
            let profileYamlFields = Set(profileYaml.keys)
            let absentFields = requiredFields.subtracting(profileYamlFields)
            fatalError(ZosmfError.zoweProfileFields(keys: absentFields).errorDescription!)
        }
        
        if let zosmfPort = profileYaml[OptionalFields.port.rawValue] as? String {
            zosmfHost += ":" + zosmfPort
        }
        
        return ZosmfConnection(
            zosmfHost: zosmfHost,
            zosmfUser: zosmfUser,
            zosmfPassword: zosmfPassword
        )
    }
}
