//
//  ZOSJobs+Delete.swift
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

extension ZOSJobs {
    
    /// Launches request to cancel a job and purge its output with the following HTTP method and URI path: DELETE /zosmf/restjobs/jobs/<jobname>/<jobid>
    /// - Parameters:
    ///   - jobName: The name of the job to be canceled and purged.
    ///   - jobId: The job Id on JES to be canceled and purged.
    ///   - onCompletion: Closure with a JSON response from z/OS system with either the result of the operation (for an asynchronous request) or the job feedback document containing details about the job that was canceled (for a synchronous request).
    ///   - response: The JSON response from z/OS system with the result of the operation or an error description.
    /// - Note: The response depends on whether the request is processed synchronously or asynchronously, as follows:
    ///   1. For an asynchronous request, the response message is expected to come with HTTP 202 status code description. To determine whether the request was successful, the caller can use getJobStatus(jobName: String, jobId: String) { response in } method.
    ///   2. For a synchronous request, to determine the success of the operation, the caller has to check the "status" property in the JSON job feedback document for a value of 0 (zero). The response message with HTTP 4nn or HTTP 5nn status code description indicates that an error occurred.
    /// - See Also: [Cancel a job and purge its output](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/IZUHPINFO_API_DeletePurgeJob.htm)
    /// - See Also: [JSON document specifications for z/OS jobs REST interface requests](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/IZUHPINFO_API_JSON_Documents.htm#JSONDocumentSpecifications__JobFeedbackDocumentContents)
    public func deleteJob(
        jobName: String,
        jobId: String,
        onCompletion: @escaping (_ response: String) -> Void
    ) {
        var customArgs = requestArguments
        customArgs.url = prepareUrl(path: jobName + "/" + jobId)
        
        requestHandler.performRequest(.DELETE, customArgs, onCompletion: { response in
            onCompletion(response)
        })
    }
}
