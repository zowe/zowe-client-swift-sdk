# Zowe Swift Client SDK

> A macOS/iOS/iPadOS/tvOS/watchOS Swift-written library for z/OSMF REST API

![](https://img.shields.io/badge/license-EPL--2.0-blue) ![](https://img.shields.io/badge/version-0.1.0-yellow)

The Zowe Swift Client SDK is an open-source Swift package for z/OSMF REST API. It allows you to leverage mainframe capabilities from your Swift applications with minimum effort.

![ZoweClientSwiftSDK](/../screenshots/Scrshots/ZoweClientSwiftSDK01.png?raw=true "ZoweClientSwiftSDK")

# Installation

Fore more details on Zowe Swift Client SDK debug version installation, follow this [INSTALL.md](INSTALL.md)

# Quickstart

Start by importing the **ZoweSDK** class. 

```swift
import ZoweSDK
```

Then create an object that will be the handler for all z/OSMF requests. 

```swift
let z = ZoweSDK(
    host: "<zosmf host>",
    port: "<zosmf port>",
    user: "<zosmf user>", 
    password: "<zosmf password>")
```

The SDK supports both manual authentication and Zowe z/OSMF mobile profiles. To create a Zowe z/OSMF mobile profile, use a regular <a href="https://developer.apple.com/documentation/swift/dictionary" target="_blank">Dictionary</a> and store it in <a href="https://developer.apple.com/documentation/foundation/userdefaults" target="_blank">UserDefaults</a> under the key with your chosen profile name. 

```swift
let zoweProfile = [
    "host": "<zosmf host>", 
    "port": "<zosmf port>", 
    "user": "<zosmf user>", 
    "password": "<zosmf password>"]
UserDefaults.standard.set(zoweProfile, forKey: "<profile name>")
```

Then to use a Zowe z/OSMF profile, simply inform the profile name while creating the object.

```swift
let z = ZoweSDK(profileName: "<profile name>")
```

# Available options

Currently, the Zowe Swift Client SDK supports the following interfaces:

* [z/OSMF information retrieval service](#zosmf) 
* [Data sets and data set members creation/listing/reading/writing/deletion](#data-sets) 
* [Jobs listing/submission/status retrieval/deletion, job spool files listing, job spool files/JCL contents retrieval](#jobs) 

## z/OSMF 

To retrieve information about z/﻿OSMF on a particular z/OS system:

```swift
z.zosmf.getInfo() { response in 
    print(response) 
}
```

Fore more details on z/OSMF for Zowe SDK package usage, follow this [README.md](zoweSDK/packages/zosmf/README.md)

## Data sets 

To create a data set (binary, C, classic, partitioned and sequential data set creation is currently supported):

```swift
z.files.createDsn(
    datasetName: "<data set name>", 
    datasetType: .<binary|c|classic|partitioned|sequential>, 
    datasetAttributes: [<attributes dictionary>]
) { response in
    print(response)
}
```

Fore more details on z/OS Files for Zowe SDK package usage, follow this [README.md](zoweSDK/packages/zosfiles/README.md)

## Jobs 

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

Fore more details on z/OS Jobs for Zowe SDK package usage, follow this [README.md](zoweSDK/packages/zosjobs/README.md)

# Acknowledgments

* Make sure to check out the [Zowe project](https://github.com/zowe)!
* For further information on z/OSMF REST API, click [HERE](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.1.0/com.ibm.zos.v2r1.izua700/IZUHPINFO_RESTServices.htm)
