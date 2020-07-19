//
//  ZOSJobs+Get.swift
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

public extension ZOSJobs {
    
    /// Launches request to to obtain the status of a batch job on z/OS with the following HTTP method and URI path: GET /zosmf/restjobs/jobs/<jobname>/<jobid>[?<parms>]
    /// - Parameters:
    ///   - jobName: The name of the job for which status is requested.
    ///   - jobId: The job Id on JES for which status is requested.
    ///   - onCompletion: Closure with a JSON response from z/OS system with a job document containing the properties of the job, such as job name, job Id, JES subsystem, job owner, job status etc.
    ///   - response: The JSON response from z/OS system with the result of the operation or an error description.
    /// - See Also: [Obtain the status of a job](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/IZUHPINFO_API_GetJobStatus.htm)
    /// - See Also: [JSON document specifications for z/OS jobs REST interface requests](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/IZUHPINFO_API_JSON_Documents.htm#JSONDocumentSpecifications__JobDocumentContents)
    public func getJobStatus(
        jobName: String,
        jobId: String,
        onCompletion: @escaping (_ response: String) -> Void
    ) {
        var customArgs = requestArguments
        customArgs.url = prepareUrl(path: jobName + "/" + jobId)
        
        requestHandler.performRequest(.GET, customArgs) { response in
            onCompletion(response)
        }
    }
    
    /// Launches request to retrieve the contents of either a job spool file on z/OS or a JCL that was used to submit the job with the following HTTP method and URI path: GET /zosmf/restjobs/jobs/<jobname>/<jobid>/files/<spoolfileid>/records
    /// - Parameters:
    ///   - jobName: The name of the job for which the spool file contents are requested.
    ///   - jobId: The job Id on JES for which the spool file contents are requested.
    ///   - spoolFileId: Optional parameter for the spool file Id for which the contents are to be retrieved. If omitted, the contents of JCL that was used to submit the job are retrieved.
    ///   - onCompletion: Closure with a JSON response from z/OS system with the contents of a job spool file. If an error occurs, the response message contains its description.
    ///   - response: The JSON response from z/OS system with the result of the operation or an error description.
    /// - See Also: [Retrieve the contents of a job spool file](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/IZUHPINFO_API_RetrieveSpoolFileContents.htm)
    public func getSpoolFileContents(
        jobName: String,
        jobId: String,
        spoolFileId: String = "JCL",
        onCompletion: @escaping (_ response: String) -> Void
    ) {
        var customArgs = requestArguments
        customArgs.url = prepareUrl(path: jobName + "/" + jobId + "/files/" + spoolFileId + "/records")
        
        requestHandler.performRequest(.GET, customArgs) { response in
            onCompletion(response)
        }
    }
}
