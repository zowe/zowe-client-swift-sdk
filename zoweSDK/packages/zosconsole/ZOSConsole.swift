//
//  ZOSConsole.swift
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

/// z/OS Console REST API class
/// - See Also: [z/OS console services](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/IZUHPINFO_API_RESTCONSOLE.htm)
public class ZOSConsole: ZOSApi {
    
    /// Console object constructor
    /// - Parameter connection: z/OS REST API connection object (generated by the ZoweSDK object)
    internal init(
        _ connection: ZOSConnection
    ) {
        super.init(connection, "")
    }
}
