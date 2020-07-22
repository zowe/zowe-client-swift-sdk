# z/OSMF for Zowe SDK

> An iOS/iPadOS Swift-written static library for z/OSMF information retrieval service REST API

![](https://img.shields.io/badge/license-EPL--2.0-blue) ![](https://img.shields.io/badge/version-0.1.0-yellow)

The z/OSMF for Zowe SDK is an open-source Swift package for z/OSMF information retrieval service REST API. It allows you to leverage mainframe capabilities from your Swift applications with minimum effort.

![zOSMFforZoweSDK](/../screenshots/Scrshots/zosmf/zOSMFforZoweSDK01.png?raw=true "zOSMFforZoweSDK")

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

The SDK supports both manual authentication and Zowe z/OSMF mobile profiles. To create a Zowe z/OSMF mobile profile, use a regular [Dictionary](https://developer.apple.com/documentation/swift/dictionary) and store it in [UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults) under the key with your chosen profile name. 

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

Currently, the z/OSMF for Zowe SDK supports the following requests:

* [z/OSMF information retrieval service](#zosmf-request-usage) 

## z/OSMF request usage 

To retrieve information about z/﻿OSMF on a particular z/OS system:

```swift
z.zosmf.getInfo() { response in 
    print(response) 
}
```

## z/OSMF response usage

The result can be either a JSON containing z/OSMF information or an error description. To get a necessary object, convert the response to [Data](https://developer.apple.com/documentation/foundation/data) format and use [JSONDecoder](https://developer.apple.com/documentation/foundation/jsondecoder) to decode it respectively: 

```swift
z.zosmf.getInfo() { response in 
    
    struct ZosmfInfo: Decodable {
        let zos_version: String
        let zosmf_port: String
        let zosmf_version: String
        let zosmf_hostname: String
        let plugins: [Plugin]
        let zosmf_saf_realm: String
        let zosmf_full_version: String
        let api_version: String
    
        struct Plugin: Decodable {
            let pluginVersion: String
            let pluginDefaultName: String
            let pluginStatus: String
        }
    }

    let jsonData = response.data(using: .utf8)
    guard let zosmfInfo = try? JSONDecoder().decode(ZosmfInfo.self, from: jsonData!) else {
        fatalError(response)
    }
    
    print(zosmfInfo)
    /* Prints the object representation for the following JSON data
    {"zos_version":"04.27.00","zosmf_port":"10443","zosmf_version":"27","zosmf_hostname":"S0W1.DAL-EBIS.IHOST.COM",
    "plugins":
    [{"pluginVersion":"HSMA240;PH19887P;2020-02-14T03:45:28","pluginDefaultName":"z\/OS Operator Consoles","pluginStatus":"ACTIVE"},
    ...
    {"pluginVersion":"HSMA240;PH22871P;2020-05-07T19:44:58","pluginDefaultName":"Cloud Provisioning","pluginStatus":"ACTIVE"}],
    "zosmf_saf_realm":"SAFRealm","zosmf_full_version":"27.0","api_version":"1"}
    */
    
    print(zosmfInfo.zos_version) // Prints "04.27.00"
}
```

# Acknowledgments

* Make sure to check out the [Zowe project](https://github.com/zowe)!
* For further information on z/OSMF REST API, click [HERE](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.1.0/com.ibm.zos.v2r1.izua700/IZUHPINFO_RESTServices.htm)
