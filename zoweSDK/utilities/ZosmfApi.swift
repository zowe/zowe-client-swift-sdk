//
//  ZosmfApi.swift
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

/// z/OSMF API attributes class
public class ZosmfApi {
    
    // MARK: - ZosmfApi private members
    
    /// z/OSMF API connection object (generated by the ZoweSDK object)
    private let connection: ZosmfConnection
    
    /// z/OSMF URI path endpoint
    private let defaultServiceUrl: String

    /// z/OSMF HTTP request default headers
    private var defaultHeaders: Dictionary<String, String> {
        [
            "Authorization": "Basic " + encodedCredentials,
            "Content-Type": "application/json; charset=UTF-8",
            "X-CSRF-ZOSMF-HEADER": "true"
        ]
    }
    
    /// Base64 encoded credentials in <mainframeId>:<password> format
    /// - See Also: [Using the z/OSMF REST services :: Basic authentication](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/IZUHPINFO_RESTServices.htm#IZUHPINFO_RESTServices__basicauth)
    private var encodedCredentials: String {
        let credentials = connection.zosmfUser + ":" + connection.zosmfPassword
        let credentialsData = credentials.data(using: .utf8)
        let credentialsOptions = Data.Base64EncodingOptions(rawValue: 0)
        guard let credentialsEncoded = credentialsData?.base64EncodedString(options: credentialsOptions) else {
            fatalError(ZosmfError.base64EncodedString.errorDescription!)
        }
        
        return credentialsEncoded
    }
    
    // MARK: - ZosmfApi internal fields
    
    /// z/OSMF full URL endpoint
    internal var requestEndpoint: URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.percentEncodedHost = connection.zosmfHost
        urlComponents.path = defaultServiceUrl
        guard let verifiedUrl = urlComponents.url else {
            fatalError(ZosmfError.invalidUrlAddress.errorDescription!)
        }
        return verifiedUrl
    }
    
    /// HTTPS request default arguments
    internal var requestArguments: (url: URL, headers: Dictionary<String, String>, body: Any?) {
        (
            requestEndpoint,
            defaultHeaders,
            nil
        )
    }
    
    /// Zowe SDK default session arguments
    internal var sessionArguments: (Double, Double) {
        (
            timeout: 30.0,
            timeoutForRequest: 60.0
        )
    }
    
    /// z/OSMF REST API HTTP request object
    internal var requestHandler: ZosmfRequestHandler {
        ZosmfRequestHandler(connection, sessionArguments)
    }
    
    // MARK: - ZosmfApi constructor
    
    /// ZosmfApi object constructor
    /// - Parameters:
    ///   - connection: The z/OSMF connection object (generated by the ZoweSDK object)
    ///   - defaultUrl: The base default endpoint url used by the REST API
    internal init(
        _ connection: ZosmfConnection,
        _ defaultUrl: String
    ) {
        self.connection = connection
        self.defaultServiceUrl = defaultUrl
    }
}
