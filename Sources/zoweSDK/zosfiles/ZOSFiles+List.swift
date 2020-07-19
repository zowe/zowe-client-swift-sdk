//
//  ZOSFiles+List.swift
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

public extension ZOSFiles {
    
    /// Launches request to retrieve a list of data sets based on the given pattern with the following HTTP method and URI path: GET /zosmf/restfiles/ds?dslevel=<dataset_name_pattern>
    /// - Parameters:
    ///   - namePattern: The name pattern for a list of data sets.
    ///   - listAttributes: Boolean value for all of the basic attributes for the data set being queried. These attributes are commonly found in the ISPF List Data set panel.. If you omit this parameter, it is set to false by default.
    ///   - onCompletion: Closure with a JSON response from z/OS system with a list of data set names matching the given pattern. If an error occurs, the response message contains its description.
    ///   - response: The JSON response from z/OS system with the result of the operation or an error description.
    /// - See Also: [List the z/OS data sets on a system](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/IZUHPINFO_API_GetListDataSets.htm)
    public func listDsn(
        namePattern: String,
        listAttributes: Bool = false,
        onCompletion: @escaping (_ response: String) -> Void
    ) {
        var customArgs = requestArguments
        let queryItem = URLQueryItem(name: "dslevel", value: namePattern)
        customArgs.url = prepareUrl(path: "ds", queryItems: [queryItem])
        if listAttributes == true {
            customArgs.headers["X-IBM-Attributes"] = "base"
        }
        
        requestHandler.performRequest(.GET, customArgs) { response in
            onCompletion(response)
        }
    }
    
    /// Launches request to retrieve a list of data set members on the given partitioned data set (PDS or PDSE) with the following HTTP method and URI path: GET /zosmf/restfiles/ds/<dataset_name>/member
    /// - Parameters:
    ///   - datasetName: The name of a z/OS data set for which members are to be listed. The length of the data set name cannot exceed 44 characters.
    ///   - onCompletion: Closure with a JSON response from z/OS system with a list of members for the given partitioned data set (PDS or PDSE). If an error occurs, the response message contains its description.
    ///   - response: The JSON response from z/OS system with the result of the operation or an error description.
    /// - See Also: [List the members of a z/OS data set](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/IZUHPINFO_API_GetListDataSetMembers.htm)
    public func listDsnMembers(
        datasetName: String,
        onCompletion: @escaping (_ response: String) -> Void
    ) {
        var customArgs = requestArguments
        customArgs.url = prepareUrl(path: "ds/" + datasetName + "/member")
        
        requestHandler.performRequest(.GET, customArgs) { response in
            onCompletion(response)
        }
    }
}
