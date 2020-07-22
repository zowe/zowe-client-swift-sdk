# Zowe Swift Client SDK Installation Guide 

> An macOS/iOS/iPadOS/tvOS/watchOS Swift-written library for z/OSMF REST API 

![](https://img.shields.io/badge/license-EPL--2.0-blue) ![](https://img.shields.io/badge/version-0.1.0-yellow) 

## Adding Zowe SDK debug version to your mobile app 

### Step 1 

Open your **macOS** or **iOS** or **iPadOS** or **tvOS** or **watchOS** application project in Xcode IDE. From menu select *File* > *Swift Packages* > *Add Package Dependency...*

![Adding Zowe Swift Client SDK as a dependency to your mobile application project](/../screenshots/Scrshots/install/ZoweClientSwiftSDK01.png?raw=true "Adding Zowe Swift Client SDK as a dependency to your mobile application project") 

### Step 2 

Once *Choose Package Repository* prompt shows up, paste `https://github.com/zowe/zowe-client-swift-sdk`  into package repository URL text field. Click *Next*. 

![Choose package repository prompt](/../screenshots/Scrshots/install/ZoweClientSwiftSDK02.png?raw=true "Choose package repository prompt") 

### Step 3 

When prompted *Choose Package Options*, choose either:
- the appropriate version (*Up to Next Major* | *Up to Next Minor* | *Range* | *Exact*, then enter version numbers, i e `1.0.0` < `2.0.0`), or 
- branch (i e `master`), or 
- commit (a valid SHA1 hash - must be 40 characters, i e `a854b3b7792df6ad34a2cd93f33856ecd9f38f0d`) to install from. 

Click *Next*.  

![Choose package options prompt](/../screenshots/Scrshots/install/ZoweClientSwiftSDK03.png?raw=true "Choose package options prompt") 

### Step 4 

Swift Package Manager should start adding Zowe SDK to your application project. 

![Resolving Zowe Swift Client SDK prompt](/../screenshots/Scrshots/install/ZoweClientSwiftSDK04.png?raw=true "Resolving Zowe Swift Client SDK prompt") 

When it finishes, make sure *ZoweSDK* box is checked for your application. Click *Finish*.

![Choose package products and targets prompt](/../screenshots/Scrshots/install/ZoweClientSwiftSDK05.png?raw=true "Choose package products and targets prompt") 

Zowe Swift Client SDK has just been added as a dependency to your application. 

![Zowe Swift Client SDK in Swift Package Dependencies](/../screenshots/Scrshots/install/ZoweClientSwiftSDK06.png?raw=true "Zowe Swift Client SDK in Swift Package Dependencies") 

## Using Zowe SDK debug version in your mobile app 

### Step 1 

Click on your mobile application's `ViewController.swift` class in the Project Navigator to the left and start by importing the **ZoweSDK** class. 

```swift
import ZoweSDK
```

![Import Zowe SDK in your mobile application ViewController class](/../screenshots/Scrshots/install/ZoweClientSwiftSDK10.png?raw=true "Import Zowe SDK in your mobile application ViewController class") 

### Step 2 

Then in `viewDidLoad` method, create an object that will be the handler for all Zowe SDK requests. 

```swift
let z = ZoweSDK(
    host: "<zosmf host>", 
    port: "<zosmf port>", 
    user: "<zosmf user>", 
    password: "<zosmf password>")
```

Add the first Zowe SDK method to retrieve information about z/﻿OSMF on a particular z/OS system and print the log into Xcode's Debug area:

```swift
z.zosmf.getInfo() { response in 
    print(response) 
}
```

![Add Zowe SDK constructor and the first method to your mobile application ViewController class](/../screenshots/Scrshots/install/ZoweClientSwiftSDK11.png?raw=true "Add Zowe SDK constructor and the first method to your mobile application ViewController class") 

### Step 3 

Click on *Set the active scheme* to expand the Devices and iOS simulators list. Select the appropriate iOS simulator for you mobile application. 

![Select the appropriate iOS simulator from the Devices and iOS simulators list](/../screenshots/Scrshots/install/ZoweClientSwiftSDK12.png?raw=true "Select the appropriate iOS simulator from the Devices and iOS simulators list") 

### Step 4 

Click ▶ to build and run your mobile application on the selected iOS simulator. You should now see the log printed into the Debug area at the bottom of your Xcode's window. 

![Build and run your mobile application with Zowe SDK on the appropriate iOS simulator](/../screenshots/Scrshots/install/ZoweClientSwiftSDK13.png?raw=true "Build and run your mobile application with Zowe SDK on the appropriate iOS simulator") 

Fore more details on Zowe SDK usage, follow this [README.md](README.md)
