//
//  ZOSFiles+Write.swift
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

extension ZOSFiles {
    
    /// Launches request to write the contents to an existing sequential data set, or a member of a partitioned data set (PDS or PDSE) with the following HTTP method and URI path: PUT /zosmf/restfiles/ds/<data_set_name>[(<member_name>)]
    /// - Parameters:
    ///   - datasetName: The name of a z/OS data set to which to write or the name of partitioned data set (PDS or PDSE) and its member (in parentheses) to which to write. The length of the data set name cannot exceed 44 characters.
    ///   - contents: The contents to write to the target data set.
    ///   - onCompletion: Closure with a JSON response from z/OS system with the result of the operation. If an error occurs, the response message contains its description.
    ///   - response: The JSON response from z/OS system with the result of the operation or an error description.
    /// - Note: The response message is expected to come with either HTTP 201 or HTTP 204 status code description
    /// - See Also: [Write data to a z/OS data set or member](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/IZUHPINFO_API_PutWriteDataSet.htm)
    public func writeToDsn(
        datasetName: String,
        contents: String,
        onCompletion: @escaping (_ response: String) -> Void
    ) {
        var customArgs = requestArguments
        customArgs.url = prepareUrl(path: "ds/" + datasetName)
        customArgs.headers["Content-Type"] = "text/plain; charset=UTF-8"
        customArgs.body = contents
        
        requestHandler.performRequest(.PUT, customArgs, onCompletion: { response in
            onCompletion(response)
        })
    }
}
