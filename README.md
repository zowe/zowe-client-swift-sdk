# Zowe Swift Client SDK

> An iOS/iPadOS Swift-written static library for z/OSMF REST API

![](https://img.shields.io/badge/license-EPL--2.0-blue) ![](https://img.shields.io/badge/version-0.1.0-yellow)

The Zowe Swift Client SDK is an open-source Swift package for z/OSMF REST API. It allows you to leverage mainframe capabilities from your Swift applications with minimum effort.

![ZoweClientSwiftSDK](/../screenshots/Scrshots/ZoweClientSwiftSDK01.png?raw=true "ZoweClientSwiftSDK")

# Quickstart

Start by importing the **zoweSDK** class. 

```swift
import zoweSDK
```

Then create an object that will be the handler for all z/OSMF requests. 

```swift
let z = ZoweSDK(zosmfHost: "<host address>", zosmfUser: "<zosmf user>", zosmfPassword: "<zosmf password>")
```

The SDK supports both manual authentication and Zowe z/OSMF mobile profiles. To create a Zowe z/OSMF mobile profile, use a regular <a href="https://developer.apple.com/documentation/swift/dictionary" target="_blank">Dictionary</a> and store it in <a href="https://developer.apple.com/documentation/foundation/userdefaults" target="_blank">UserDefaults</a> under the key with your chosen profile name. 

```swift
let zoweProfile = ["host": "<host address>", "port": "<host port>", "user": "<zosmf user>", "password": "<zosmf password>"]
UserDefaults.standard.set(zoweProfile, forKey: "<profile name>")
```

Then to use a Zowe z/OSMF profile, simply inform the profile name while creating the object.

```swift
let z = ZoweSDK(zosmfProfile: "<profile name>")
```

# Available options

Currently, the Zowe Swift Client SDK supports the following interfaces:

* z/OSMF Information retrieval

## z/OSMF

Usage of the z/OSMF REST API

```swift
z.zosmf.getInfo() { response in print(response) }
```

The result can be either a JSON containing z/OSMF information or an error description. To get a necessary object, convert the response to <a href="https://developer.apple.com/documentation/foundation/data" target="_blank">Data</a> format and use <a href="https://developer.apple.com/documentation/foundation/jsondecoder" target="_blank">JSONDecoder</a> to decode it respectively. 

```swift
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
let zosmfInfo = try? JSONDecoder().decode(ZosmfInfo.self, from: jsonData!)
print(zosmfInfo?.zos_version) // Prints "04.27.00"
```

# Acknowledgments

* Make sure to check out the [Zowe project](https://github.com/zowe)!
* For further information on z/OSMF REST API, click [HERE](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.1.0/com.ibm.zos.v2r1.izua700/IZUHPINFO_RESTServices.htm)
