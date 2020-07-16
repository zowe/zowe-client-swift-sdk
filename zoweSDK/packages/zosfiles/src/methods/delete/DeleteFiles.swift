//
//  DeleteFiles.swift
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
    
    /// Launches request to delete sequential and partitioned data sets, or a member of a partitioned data set (PDS or PDSE) with the following HTTP method and URI path: DELETE /zosmf/restfiles/ds/<data_set_name>[(<member_name>)]
    /// - Parameters:
    ///   - datasetName: The name of a z/OS data set, that you are going to delete, or the name of a z/OS data set that contains a member you are going to delete, followed by the name of the partitioned data set member (in parentheses) to be deleted.
    ///   - onCompletion: Closure with a JSON response from z/OS system with the result of the operation. If an error occurs, the response message contains its description.
    ///   - response: The JSON response from z/OS system with the result of the operation or an error description.
    /// - Note: The response message is expected to come with HTTP 204 status code description
    /// - See Also: [Delete a sequential and partitioned data set](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/IZUHPINFO_API_DeleteDataSet.htm)
    /// - See Also: [Delete a partitioned data set member](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/IZUHPINFO_API_DeletePartitionedDataSet.htm)
    public func deleteDsn(
        datasetName: String,
        onCompletion: @escaping (_ response: String) -> Void
    ) {
        var customArgs = requestArguments
        customArgs.url = prepareUrl(path: "ds/" + datasetName)
        
        requestHandler.performRequest(.DELETE, customArgs, onCompletion: { response in
            onCompletion(response)
        })
    }
}
