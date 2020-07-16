//
//  ListJobs.swift
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
    
    /// Launches request to retrieve a list of jobs on JES for an owner, prefix, max-jobs and/or user-correlator with the following HTTP method and URI path: GET /zosmf/restjobs/jobs[?<parms>]
    /// - Parameters:
    ///   - owner: Optional parameter for user Id of the job owner whose jobs are being queried. If omitted, the default is the z/OS user Id. Folded to uppercase, cannot exceed 8 characters.
    ///   - prefix: Optional parameter for job name prefix. If omitted, default is *. Folded to uppercase, cannot exceed 8 characters.
    ///   - maxJobs: Optional parameter for maximum number of jobs returned. The value must be in the range 1 - 1000. If omitted or specified incorrectly, the default value of 1000 is used.
    ///   - userCorrelator: Optional parameter for the user portion of the job correlator. This value is 1 – 32 characters in length, where the first character must be uppercase alphabetic (A-Z) or special ($, #, @). The remaining characters (up to 31) can be any combination of uppercase alphabetic, numeric (0-9), or special. Blank characters are not supported. This query parameter is mutually exclusive with jobId. This value is processed by the JES2 subsystem only; the JES3 subsystem does not process the correlator and instead indicates zero job matches. For a system with JES3 as the primary subsystem, and one or more JES2 secondary subsystems, the primary JES3 subsystem does not process the correlator, however, the JES2 secondary subsystems can process the correlator.
    ///   - onCompletion: Closure with a JSON response from z/OS system with an array of zero or more JSON job documents containing the properties of the job, such as job name, job Id, JES subsystem, job owner, job status etc. If an error occurs, the response message contains its description.
    ///   - response: The JSON response from z/OS system with the result of the operation or an error description.
    /// - See Also: [List the jobs for an owner, prefix, or job ID](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/IZUHPINFO_API_GetListJobs.htm)
    /// - See Also: [JSON document specifications for z/OS jobs REST interface requests](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/IZUHPINFO_API_JSON_Documents.htm#JSONDocumentSpecifications__JobDocumentContents)
    public func listJobs(
        owner: String? = nil,
        prefix: String = "*",
        maxJobs: Int = 1000,
        userCorrelator: String? = nil,
        onCompletion: @escaping (_ response: String) -> Void
    ) {
        var customArgs = requestArguments
        var queryItems = [
            URLQueryItem(name: "owner", value: owner ?? zosmfUser),
            URLQueryItem(name: "prefix", value: prefix),
            URLQueryItem(name: "max-jobs", value: String(maxJobs))
        ]
        if let userCorrelator = userCorrelator {
            queryItems.append(URLQueryItem(name: "user-correlator", value: userCorrelator))
        }
        customArgs.url = prepareUrl(queryItems: queryItems)
        
        requestHandler.performRequest(.GET, customArgs) { response in
            onCompletion(response)
        }
    }
    
    /// Launches request to list the spool files for a batch job on z/OS with the following HTTP method and URI path: GET /zosmf/restjobs/jobs/<jobname>/<jobid>/files
    /// - Parameters:
    ///   - jobName: The name of the job for which the spool files are to be listed.
    ///   - jobId: The job Id on JES for which the spool files are to be listed.
    ///   - onCompletion: Closure with a JSON response from z/OS system with an array of zero or more JSON job file documents containing the properties of the job file, such as job file stepname, job file ddname, job file Id etc. If an error occurs, the response message contains its description.
    ///   - response: The JSON response from z/OS system with the result of the operation or an error description.
    /// - See Also: [List the spool files for a job](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/IZUHPINFO_API_GetListSpoolFiles.htm)
    /// - See Also: [JSON document specifications for z/OS jobs REST interface requests](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/IZUHPINFO_API_JSON_Documents.htm#JSONDocumentSpecifications__JobFileDocumentContents)
    public func listSpoolFiles(
        jobName: String,
        jobId: String,
        onCompletion: @escaping (_ response: String) -> Void
    ) {
        var customArgs = requestArguments
        customArgs.url = prepareUrl(path: jobName + "/" + jobId + "/files")
        
        requestHandler.performRequest(.GET, customArgs) { response in
            onCompletion(response)
        }
    }
}
