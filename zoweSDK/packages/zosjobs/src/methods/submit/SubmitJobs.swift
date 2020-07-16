//
//  SubmitJobs.swift
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
    
    /// Launches request to submit a job to run on z/OS from specified file location with the following HTTP method and URI path: PUT /zosmf/restjobs/jobs[/-<JESB>]
    /// - Parameters:
    ///   - jclPath: The data set or UNIX file that contains the job to be submitted.
    ///   - onCompletion: Closure with a JSON response from z/OS system with a job document containing the properties of the job created, such as job name, job Id, JES subsystem, job owner, job status etc.
    ///   - response: The JSON response from z/OS system with the result of the operation or an error description.
    /// - Important:
    ///   1. For a data set, specify the qualified data set name, prefixing the data set name with two leading forward slash characters (“//”). If not fully qualified, the current z/﻿OSMF user Id is prefixed to the data set name. Supported data set types include sequential data sets and members of partitioned data sets. Data sets must be catalogued.
    ///   2. For a z/OS UNIX file, specify the absolute path name of the file. Code page conversion is not performed on the contents of the file.
    /// - See Also: [Submit a job](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/IZUHPINFO_API_PutSubmitJob.htm)
    /// - See Also: [JSON document specifications for z/OS jobs REST interface requests](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/IZUHPINFO_API_JSON_Documents.htm#JSONDocumentSpecifications__JobDocumentContents)
    public func submitFromMainframe(
        jclPath: String,
        onCompletion: @escaping (_ response: String) -> Void
    ) {
        var customArgs = requestArguments
        customArgs.body = ["file": "//'" + jclPath + "'"]
        
        requestHandler.performRequest(.PUT, customArgs) { response in
            onCompletion(response)
        }
    }
    
    /// Launches request to submit a job to run on z/OS from plain text input with the following HTTP method and URI path: PUT /zosmf/restjobs/jobs[/-<JESB>]
    /// - Parameters:
    ///   - jcl: The job JCL to include in the HTTP request itself as a plain text
    ///   - onCompletion: Closure with a JSON response from z/OS system with a job document containing the properties of the job created, such as job name, job Id, JES subsystem, job owner, job status etc.
    ///   - response: The JSON response from z/OS system with the result of the operation or an error description.
    /// - See Also: [Submit a job](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/IZUHPINFO_API_PutSubmitJob.htm)
    /// - See Also: [JSON document specifications for z/OS jobs REST interface requests](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.4.0/com.ibm.zos.v2r4.izua700/IZUHPINFO_API_JSON_Documents.htm#JSONDocumentSpecifications__JobDocumentContents)
    public func submitPlainText(
        jcl: String,
        onCompletion: @escaping (_ response: String) -> Void
    ) {
        var customArgs = requestArguments
        customArgs.headers["Content-Type"] = "text/plain; charset=UTF-8"
        customArgs.body = jcl
        
        requestHandler.performRequest(.PUT, customArgs) { response in
            onCompletion(response)
        }
    }
}
