# z/OS Files for Zowe SDK

> An iOS/iPadOS Swift-written static library for z/OS data sets and files REST API

![](https://img.shields.io/badge/license-EPL--2.0-blue) ![](https://img.shields.io/badge/version-0.1.0-yellow)

The z/OS Files for Zowe SDK is an open-source Swift package for z/OS data sets and files REST API. It allows you to leverage mainframe capabilities from your Swift applications with minimum effort.

![zOSFilesforZoweSDK](/../screenshots/Scrshots/zosfiles/zOSFilesforZoweSDK01.png?raw=true "zOSFilesforZoweSDK")

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

Currently, the z/OS Files for Zowe SDK supports the following requests:

* [Data sets creation](#data-sets-creation) 
* [Data sets and data set members listing](#data-sets-and-data-set-members-listing) 
* [Data sets and data set members reading](#data-sets-and-data-set-members-reading) 
* [Data sets and data set members writing (can be used to create data set members as well)](#data-sets-and-data-set-members-writing) 
* [Data sets and data set members deletion](#data-sets-and-data-set-members-deletion) 

## Data sets creation 

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

**NOTE**: You can omit data set attributes parameter, then Zowe SDK will use the default attributes for the relevant data set type. Pay attention at the response description for data sets and data set members creation request (see this method description with option-click on the method name in Xcode IDE).

## Data sets and data set members listing 

To list the z/OS data sets on a system:

```swift
z.files.listDsn(
    namePattern: "<data set name pattern>"
) { response in
    print(response)
}
```

To list the z/OS data sets with the full attributes:

```swift
z.files.listDsn(
    namePattern: "<data set name pattern>", 
    listAttributes: true
) { response in
    print(response)
}
```

To list the members of a z/OS data set:

```swift
z.files.listDsnMembers(
    datasetName: "<data set name>"
) { response in
    print(response)
}
```

## Data sets and data set members reading 

To retrieve the contents of a z/OS data set or member:

```swift
z.files.getDsnContents(
    datasetName: "<data set name>[(<member name>)]"
) { response in
    print(response)
}
```

## Data sets and data set members writing 

To write the contents to a z/OS data set or member:

```swift
z.files.writeToDsn(
    datasetName: "<data set name>[(<member name>)]", 
    contents: "<contents to write>"
) { response in
    print(response)
}
```

**NOTE**: You can use this method to create a member of a partitioned data set and write its contents simultaneously, that is if the *<member name>* doesn't exist, it will be created automatically. Pay attention at the response description for data sets and data set members writing request (see this method description with option-click on the method name in Xcode IDE).

## Data sets and data set members deletion 

To delete a sequential or partitioned data set, or a partitioned data set member:

```swift
z.files.deleteDsn(
    datasetName: "<data set name>[(<member name>)]"
) { response in 
    print(response) 
}
```

**NOTE**: Technically, binary, C and classic data sets are all partitioned ones. Pay attention at the response description for data sets and data set members deletion request (see this method description with option-click on the method name in Xcode IDE).

## Response usage

The result can be either a JSON response from z/OS system with the result of the operation or an error description. To get a necessary object, convert the response to <a href="https://developer.apple.com/documentation/foundation/data" target="_blank">Data</a> format and use <a href="https://developer.apple.com/documentation/foundation/jsondecoder" target="_blank">JSONDecoder</a> to decode it respectively: 

```swift
z.files.listDsn(
    namePattern: "Z99998.*", 
    listAttributes: true
) { response in
    
    struct DataSets: Decodable {
        let items: [Dsn]
        
        struct Dsn: Decodable {
            let dsname: String
            let blksz: String?
            let catnm: String?
            let cdate: String?
            let dev: String?
            let dsntp: String?
            let dsorg: String?
            let edate: String?
            let extx: String?
            let lrecl: String?
            let migr: String?
            let mvol: String?
            let ovf: String?
            let rdate: String?
            let recfm: String?
            let sizex: String?
            let spacu: String?
            let used: String?
            let vol: String?
            let vols: String?
        }
    }
    
    let jsonData = response.data(using: .utf8)
    guard let datasets = try? JSONDecoder().decode(DataSets.self, from: jsonData!) else {
        fatalError(response)
    }
    
    print(datasets.items)
    /* Prints the object representation for the following JSON data
    {"items":[
      {"dsname":"Z99998.CBL","blksz":"32720","catnm":"CATALOG.ZOS3","cdate":"2020/04/29","dev":"3390","dsntp":"LIBRARY","dsorg":"PO-E","edate":"***None***","extx":"1","lrecl":"80","migr":"NO","mvol":"N","ovf":"NO","rdate":"2020/07/14","recfm":"FB","sizex":"15","spacu":"CYLINDERS","used":"32","vol":"VPWRKE","vols":"VPWRKE"},
      {"dsname":"Z99998.DATA","blksz":"27880","catnm":"CATALOG.ZOS3","cdate":"2020/04/29","dev":"3390","dsorg":"PS","edate":"***None***","extx":"1","lrecl":"170","migr":"NO","mvol":"N","ovf":"NO","rdate":"2020/07/08","recfm":"FB","sizex":"1","spacu":"TRACKS","used":"100","vol":"VPWRKE","vols":"VPWRKE"},
      {"dsname":"Z99998.JCL","blksz":"32720","catnm":"CATALOG.ZOS3","cdate":"2020/04/29","dev":"3390","dsntp":"LIBRARY","dsorg":"PO-E","edate":"***None***","extx":"1","lrecl":"80","migr":"NO","mvol":"N","ovf":"NO","rdate":"2020/07/14","recfm":"FB","sizex":"15","spacu":"CYLINDERS","used":"16","vol":"VPWRKE","vols":"VPWRKE"},
      {"dsname":"Z99998.LOAD","blksz":"4096","catnm":"CATALOG.ZOS3","cdate":"2020/04/29","dev":"3390","dsntp":"LIBRARY","dsorg":"PO-E","edate":"***None***","extx":"2","lrecl":"0","migr":"NO","mvol":"N","ovf":"NO","rdate":"2020/07/14","recfm":"U","sizex":"30","spacu":"CYLINDERS","used":"61","vol":"VPWRKE","vols":"VPWRKE"},
      {"dsname":"Z99998.PDS","blksz":"6160","catnm":"CATALOG.ZOS3","cdate":"2020/07/06","dev":"3390","dsntp":"PDS","dsorg":"PO","edate":"***None***","extx":"1","lrecl":"80","migr":"NO","mvol":"N","ovf":"NO","rdate":"2020/07/14","recfm":"FB","sizex":"150","spacu":"CYLINDERS","used":"1","vol":"VPWRKB","vols":"VPWRKB"},
      {"dsname":"Z99998.SPFLOG1.LIST","blksz":"129","catnm":"CATALOG.ZOS3","cdate":"2020/07/13","dev":"3390","dsorg":"PS","edate":"***None***","extx":"1","lrecl":"125","migr":"NO","mvol":"N","ovf":"NO","rdate":"2020/07/13","recfm":"VA","sizex":"9","spacu":"BLOCKS","used":"11","vol":"VPWRKA","vols":"VPWRKA"},
      {"dsname":"Z99998.S0W1.ISPF.ISPPROF","blksz":"27920","catnm":"CATALOG.ZOS3","cdate":"2020/04/29","dev":"3390","dsntp":"PDS","dsorg":"PO","edate":"***None***","extx":"1","lrecl":"80","migr":"NO","mvol":"N","ovf":"NO","rdate":"2020/07/14","recfm":"FB","sizex":"1","spacu":"TRACKS","used":"100","vol":"VPWRKE","vols":"VPWRKE"}
    ],"returnedRows":7,"JSONversion":1}
    */
    
    print(datasets.items.first(where: { $0.dsname == "Z99998.PDS" })?.lrecl) 
    // Prints "80"
}
```

# Acknowledgments

* Make sure to check out the [Zowe project](https://github.com/zowe)!
* For further information on z/OSMF REST API, click [HERE](https://www.ibm.com/support/knowledgecenter/SSLTBW_2.1.0/com.ibm.zos.v2r1.izua700/IZUHPINFO_RESTServices.htm)
