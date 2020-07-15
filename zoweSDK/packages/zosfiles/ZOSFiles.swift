//
//  ZOSFiles.swift
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

/// z/OS Files REST API class
/// - See Also: [z/OS data set and file REST interface](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/IZUHPINFO_API_RESTFILES.htm)
public class ZOSFiles: ZOSApi {
    
    /// Files object constructor
    /// - Parameter connection: z/OS REST API connection object (generated by the ZoweSDK object)
    internal init(
        _ connection: ZOSConnection
    ) {
        super.init(connection, "/zosmf/restfiles/")
    }
    
    /// Prepares URL object and verifies its validity
    /// - Parameters:
    ///   - path: URL path component to append.
    ///   - queryItems: Optional parameter for URL query items to append if any.
    /// - Returns: Verified URL object to use for HTTP request.
    internal func prepareUrl(
        path: String,
        queryItems: [URLQueryItem]? = nil
    ) -> URL {
        var urlComponents = URLComponents()
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        guard let verifiedUrl = urlComponents.url(relativeTo: requestArguments.url) else {
            fatalError(ZOSError.invalidUrlAddress.errorDescription!)
        }
        return verifiedUrl
    }
}
