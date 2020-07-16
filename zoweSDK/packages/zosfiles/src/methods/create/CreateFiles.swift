//
//  CreateFiles.swift
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
    
    /// Launches request to create sequential or partitioned data sets on a z/OS system with the following HTTP method and URI path: POST /zosmf/restfiles/ds/<dataset_name>
    /// - Parameters:
    ///   - datasetName: The name of a z/OS data set to create. The length of the data set name cannot exceed 44 characters.
    ///   - datasetType: The data set type describing the necessary kind of data set to be created
    ///   - datasetAttributes: Optional parameter for the attributes to be used as options for the data sets to be created. If omitted, the default attributes for a given data set are used.
    ///   - onCompletion: Closure with a JSON response from z/OS system with the result of the operation. If an error occurs, the response message contains its description.
    ///   - response: The JSON response from z/OS system with the result of the operation or an error description.
    /// - Important: [Data set naming rules](https://www.ibm.com/support/knowledgecenter/en/SSLTBW_2.1.0/com.ibm.zos.v2r1.ikjp100/ikjp10056.htm):
    ///   1. A data set name consists of one or more parts connected by periods. Each part is called a qualifier
    ///   2. Each qualifier must begin with an alphabetic character (A to Z) or the special character @, #, or $
    ///   3. The remaining characters in each qualifier can be alphabetic, special, or numeric (0 to 9) characters
    ///   4. Each qualifier must be 1 to 8 characters in length
    ///   5. The maximum length of a complete data set name before specifying a member name is 44 characters, including the periods
    /// - Note: The response message is expected to come with HTTP 201 status code description
    /// - See Also: [Create a sequential and partitioned data set](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/IZUHPINFO_API_CreateDataSet.htm)
    public func createDsn(
        datasetName: String,
        datasetType: DatasetTypes,
        datasetAttributes: [String: Any]? = nil,
        onCompletion: @escaping (_ response: String) -> Void
    ) {
        var customArgs = requestArguments
        customArgs.url = prepareUrl(path: "ds/" + datasetName)
        customArgs.body = datasetAttributes ?? datasetType.defaultAttributes()
        
        requestHandler.performRequest(.POST, customArgs, onCompletion: { response in
            onCompletion(response)
        })
    }
}
