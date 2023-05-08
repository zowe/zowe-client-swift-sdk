//
//  Zosmf.swift
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

/// z/OSMF REST API information retrieval service class
/// - See Also: [z/OSMF information retrieval service](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/izuprog_API_QueryService.htm)
public class Zosmf: ZOSApi {
    
    // MARK: - Zosmf constructor
    
    /// Zosmf object constructor
    /// - Parameter connection: z/OS REST API connection object (generated by the ZoweSDK object)
    internal init(
        _ connection: ZOSConnection
    ) {
        super.init(connection, "/zosmf/info")
    }
    
    // MARK: - Zosmf public methods
    
    /// Launches request to retrieve information about z/﻿OSMF on a particular z/OS system with the following HTTP method and URI path: GET /zosmf/info
    /// - Parameters:
    ///   - onCompletion: Closure with a JSON response from z/OSMF information retrieval service with the version and other details about the instance of z/﻿OSMF running on a particular system. If an error occurs, the response message contains its description.
    ///   - response: The JSON response from z/OS system with the result of the operation or an error description.
    /// - See Also: [Retrieve z/﻿OSMF information](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/izuprog_API_GetRetrieveVersionInfo.htm)
    public func getInfo(
        onCompletion: @escaping (_ response: String) -> Void
    ) {
        requestHandler.performRequest(.GET, requestArguments) { response in
            onCompletion(response)
        }
    }
}