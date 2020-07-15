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
    internal let zosmfHost: String
    
    /// The mainframe Id for the z/OS REST API
    internal let zosmfUser: String
    
    /// The password for the z/OS REST API
    internal let zosmfPassword: String
}
