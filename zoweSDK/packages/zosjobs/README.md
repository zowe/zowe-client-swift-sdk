# z/OS Jobs for Zowe SDK

> An iOS/iPadOS Swift-written static library for z/OS jobs REST API

![](https://img.shields.io/badge/license-EPL--2.0-blue) ![](https://img.shields.io/badge/version-0.1.0-yellow)

The z/OS Jobs for Zowe SDK is an open-source Swift package for z/OS jobs REST API. It allows you to leverage mainframe capabilities from your Swift applications with minimum effort.

![zOSJobsforZoweSDK](/../screenshots/Scrshots/zosjobs/zOSJobsforZoweSDK01.png?raw=true "zOSJobsforZoweSDK")

# Quickstart

Start by importing the **zoweSDK** class. 

```swift
import zoweSDK
```

Then create an object that will be the handler for all z/OSMF requests. 

```swift
let z = ZoweSDK(
    zosmfHost: "<host address>", 
    zosmfUser: "<zosmf user>", 
    zosmfPassword: "<zosmf password>")
```

The SDK supports both manual authentication and Zowe z/OSMF mobile profiles. To create a Zowe z/OSMF mobile profile, use a regular <a href="https://developer.apple.com/documentation/swift/dictionary" target="_blank">Dictionary</a> and store it in <a href="https://developer.apple.com/documentation/foundation/userdefaults" target="_blank">UserDefaults</a> under the key with your chosen profile name. 

```swift
let zoweProfile = [
    "host": "<host address>", 
    "port": "<host port>", 
    "user": "<zosmf user>", 
    "password": "<zosmf password>"]
UserDefaults.standard.set(zoweProfile, forKey: "<profile name>")
```

Then to use a Zowe z/OSMF profile, simply inform the profile name while creating the object.

```swift
let z = ZoweSDK(zosmfProfile: "<profile name>")
```

# Available options

Currently, the z/OS Jobs for Zowe SDK supports the following requests:

* [Jobs and job spool files listing](#jobs-and-job-spool-files-listing) 
* [Job status retrieval](#job-status-retrieval) 
* [Job spool file contents and job JCL getting](#job-spool-file-contents-and-job-JCL-getting) 
* [Job submission (both from Mainframe and from plain text)](#job-submission)  
* [Job deletion](#job-deletion) 

## Jobs and job spool files listing 

To list the jobs for an owner, prefix, max-jobs and/or user-correlator:

```swift
z.jobs.listJobs(
    owner: [<owner>],
    prefix: [<prefix>],
    maxJobs: [<max-jobs>],
    userCorrelator: [<user-correlator>]
) { response in
    print(response)
}
```

**NOTE**: You can omit any or all of those parameters, then Zowe SDK will use the default values for them (see this method description with option-click on the method's name in Xcode IDE).

To list the spool files for a batch job on z/OS:

```swift
z.jobs.listSpoolFiles(
    jobName: <jobname>,
    jobId: <jobid>
) { response in
    print(response)
}
```

## Job status retrieval 

To obtain the status of a batch job on z/OS:

```swift
z.jobs.getJobStatus(
    jobName: <jobname>,
    jobId: <jobid>
) { response in
    print(response)
}
```

## Job spool file contents and job JCL getting 

To retrieve the contents of a job spool file on z/OS:

```swift
z.jobs.getSpoolFileContents(
    jobName: <jobname>,
    jobId: <jobid>,
    spoolFileId: <spoolfileid>
) { response in
    print(response)
}
```

**NOTE**: To retrieve the JCL that was used to submit the job, just omit the *spoolFileId* parameter.

## Job submission  

To submit a job to run on z/OS from specified file location:

```swift
z.jobs.submitFromMainframe(
    jclPath: <path to JCL>
) { response in
    print(response)
}
```

To submit a job to run on z/OS from plain text input: 

```swift
z.jobs.submitPlainText(
    jcl: <JCL contents to execute>
) { response in
    print(response)
}
```

## Job deletion 

To cancel a job and purge its output:

```swift
z.jobs.deleteJob(
    jobName: <jobname>,
    jobId: <jobid>
) { response in 
    print(response) 
}
```

**NOTE**: Pay attention at the response description for job deletion request (see this method description with option-click on the method name in Xcode IDE).

## Response usage

The result can be either a JSON response from z/OS system with the result of the operation or an error description. To get a necessary object, convert the response to <a href="https://developer.apple.com/documentation/foundation/data" target="_blank">Data</a> format and use <a href="https://developer.apple.com/documentation/foundation/jsondecoder" target="_blank">JSONDecoder</a> to decode it respectively: 

```swift
z.jobs.listJobs() { response in
    
    struct Job: Decodable {
        let owner: String
        let phase: Int
        let subsystem: String
        let type: String
        let url: String
        let jobid: String
        let jobname: String
        let status: String
        let retcode: String?
    }
    
    let jsonData = response.data(using: .utf8)
    guard let jobs = try? JSONDecoder().decode(Array<Job>.self, from: jsonData!) else {
        fatalError(response)
    }
    
    print(jobs)
    /* Prints the object representation for the following JSON data
    [
        {"owner":"Z99998","phase":20,"subsystem":"JES2","phase-name":"Job is on the hard copy queue","job-correlator":"T0001802SVSCJES2D839D7AB.......:","type":"TSU","url":"https:\/\/192.86.32.250:10443\/zosmf\/restjobs\/jobs\/T0001802SVSCJES2D839D7AB.......%3A","jobid":"TSU01802","class":"TSU","files-url":"https:\/\/192.86.32.250:10443\/zosmf\/restjobs\/jobs\/T0001802SVSCJES2D839D7AB.......%3A\/files","jobname":"Z99998","status":"OUTPUT","retcode":"ABEND S222"},
        {"owner":"Z99998","phase":20,"subsystem":"JES2","phase-name":"Job is on the hard copy queue","job-correlator":"J0001769SVSCJES2D839AE96.......:","type":"JOB","url":"https:\/\/192.86.32.250:10443\/zosmf\/restjobs\/jobs\/J0001769SVSCJES2D839AE96.......%3A","jobid":"JOB01769","class":"A","files-url":"https:\/\/192.86.32.250:10443\/zosmf\/restjobs\/jobs\/J0001769SVSCJES2D839AE96.......%3A\/files","jobname":"HELLOCBL","status":"OUTPUT","retcode":"CC 0000"}
    ]
    */
    
    print(jobs.first(where: { $0.jobname == "HELLOCBL" && $0.jobid == "JOB01769" })?.status) 
    // Prints "OUTPUT"
}
```

# Acknowledgments

* Make sure to check out the [Zowe project](https://github.com/zowe)!
* For further information on z/OSMF REST API, click [HERE](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.1.0/com.ibm.zos.v2r1.izua700/IZUHPINFO_RESTServices.htm)
