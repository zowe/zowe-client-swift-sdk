//
//  ZosmfError.swift
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

// MARK: - ZosmfError enumeration

/// z/OSMF error helper
internal enum ZosmfError: LocalizedError {
    case zoweProfile(name: String)
    case zoweProfileFields(keys: Set<String>)
    case base64EncodedString
    case invalidUrlAddress
    case invalidHttpBody(reason: String)
    case httpStatus(code: Int)
    
    /// A brief message describing what kind of Zowe SDK error occurred
    var errorDescription: String? {
        switch self {
        case let .zoweProfile(name):
            return "Zowe profile with \"" + name + "\" name not found or not of correct type"
        case let .zoweProfileFields(keys):
            return "Zowe profile field(s) with \"" + keys.joined(separator: "\", \"") + "\" name(s) not found or not of \"String\" type"
        case .base64EncodedString:
            return "Base64 credentials encoding error"
        case .invalidUrlAddress:
            return "Invalid URL address error"
        case let .invalidHttpBody(reason):
            return "HTTP request body error: " + reason
        case let .httpStatus(code):
            return code.httpDescription()
        }
    }
}

// MARK: - ZosmfError Int extension

fileprivate extension Int {
    /// The HTTP response status code description
    /// - Returns: String description of the given HTTP response status code
    /// - See Also: [HTTP status codes](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/izuprog_API_WorkflowServices.htm)
    func httpDescription() -> String {
        switch self {
        case 200:
            return "HTTP 200 OK - Request was processed successfully."
        case 201:
            return "HTTP 201 Created - Request was successful, and, as a result, a resource was created."
        case 202:
            return "HTTP 202 Accepted - Request was received and accepted for processing, but the processing has not yet completed."
        case 204:
            return "HTTP 204 No Content - Request was processed successfully, however, no content was returned. This status is normal for some types of requests, such as when no data sets or files match the filter criteria, or the specified partitioned data set has no members."
        case 206:
            return "HTTP 206 Partial content - Request was processed successfully, however, only a portion of the available content was received. The request contained the X-IBM-Max-Items header, which limited the amount of content that was returned."
        case 304:
            return "HTTP 304 Not Modified - An ETag token was included in the request. z/﻿OSMF determined that the requested resource did not change since the ETag token was created."
        case 400:
            return "HTTP 400® Bad request - Request could not be processed because it contains a syntax error or an incorrect parameter."
        case 401:
            return "HTTP 401 Unauthorized - Request could not be processed because the client is not authorized. This status is returned if the request contained an incorrect user ID or password, or both, or the client did not authenticate to z/﻿OSMF."
        case 403:
            return "HTTP 403 Not authorized"
        case 404:
            return "HTTP 404 Not found - Requested resource does not exist."
        case 405:
            return "HTTP 405 Method not allowed - Requested resource is a valid resource, but an incorrect method was used to submit the request. For example, the request used the POST method when the GET method was expected."
        case 408:
            return "HTTP 408 Request timed out - The client did not produce a request within the allowed time. The request can be submitted again later."
        case 409:
            return "HTTP 409 Request conflict - The request cannot be processed because of conflict in the request, such as an edit conflict between multiple updates."
        case 412:
            return "HTTP 412 Precondition failed - The supplied ETag token indicated that the resource was modified since the token was created. Therefore, the request failed the If-Match precondition that was specified in the header."
        case 413:
            return "HTTP 413 Request entity too large - The supplied data is too large to process. Or, the requested resource is too large to return."
        case 429:
            return "HTTP 429 Too many requests - The client submitted too many unsuccessful login attempts."
        case 500:
            return "HTTP 500 Internal server error - Server encountered an error. See the response body for a JSON object with information about the error."
        case 503:
            return "HTTP 503 Service unavailable - The request cannot be carried out by the server because of a temporary condition. A suggested wait time might be indicated in a Retry-After header, if one is provided in the response. Otherwise, the requestor can treat the response as a 500 response."
        case 504:
            return "HTTP 504 Gateway timeout - The server, which is acting as a gateway or proxy, did not receive a timely response from the server that was specified in the URI path (for example, HTTP, FTP, LDAP) or an auxiliary server (such as DNS). This access is needed to complete the request. For example, the server was not able to start a remote REXX or UNIX shell interface."
        default:
            return "HTTP \(self)"
        }
    }
}
