//
//  ZoweSDK+ZOSJobs.swift
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

extension ZoweSDK {
    
    // MARK: - ZoweSDK public members
    
    /// z/OSMF REST API information retrieval service object
    public var jobs: ZOSJobs {
        ZOSJobs(connection)
    }
}
