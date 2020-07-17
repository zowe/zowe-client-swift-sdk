# Zowe Swift Client SDK Installation Guide 

> An iOS/iPadOS Swift-written static library for z/OSMF REST API 

![](https://img.shields.io/badge/license-EPL--2.0-blue) ![](https://img.shields.io/badge/version-0.1.0-yellow) 

## Building Zowe SDK debug version 

### Step 1 

Download the latest <a href="https://apps.apple.com/us/app/xcode/id497799835" target="_blank">Xcode IDE</a> from Mac App Store and install it. 

![Xcode IDE in Mac App Store](/../screenshots/Scrshots/install/ZoweClientSwiftSDK01.png?raw=true "Xcode IDE in Mac App Store") 

### Step 2 

Download <a href="archive/master.zip" target="_blank">zowe-client-swift-sdk</a> project, unzip it and double-click *zoweSDK.xcodeproj* file to open it in Xcode IDE. 

![Zowe Client Swift SDK folder](/../screenshots/Scrshots/install/ZoweClientSwiftSDK02.png?raw=true "Zowe Client Swift SDK folder") 

### Step 3 

Xcode IDE opens Zowe SDK project. Click ▶ button in the upper-left corner of Xcode window to build Zowe SDK. The build process uses a special *zsh* run script to construct so-called "fat static library", which can be used on both iOS simulators and iPhone devices (i e under *x86_64* and *arm64* architecture). 

![Zowe Client Swift SDK project](/../screenshots/Scrshots/install/ZoweClientSwiftSDK03.png?raw=true "Zowe Client Swift SDK project") 

### Step 4

The build should take about half a minute. After *Build succeeded* message, *zsh* run script should open Zowe SDK project folder with a new *zoweSDK.framework* folder created in it. You can now close Zowe SDK project in Xcode IDE.

![Zowe Client Swift SDK build process](/../screenshots/Scrshots/install/ZoweClientSwiftSDK04.png?raw=true "Zowe Client Swift SDK build process") 

![Zowe Client Swift SDK framework folder](/../screenshots/Scrshots/install/ZoweClientSwiftSDK05.png?raw=true "Zowe Client Swift SDK framework folder") 

## Adding Zowe SDK debug version to your mobile app 

### Step 1 

Open your mobile application project in Xcode IDE. Drag and drop *zoweSDK.framework* from Zowe SDK folder into Xcode window, so that it falls right under your mobile application's header icon in the Project Navigator to the left.

![Add Zowe Client Swift SDK to your mobile application project](/../screenshots/Scrshots/install/ZoweClientSwiftSDK06.png?raw=true "Add Zowe Client Swift SDK to your mobile application project") 

### Step 2 

When *Choose options for adding these files* prompt shows up, make sure *Copy items if needed* box is checked, *Create groups* radio button is selected and your mobile application target box is checked as well.

![Choose options for adding these files prompt](/../screenshots/Scrshots/install/ZoweClientSwiftSDK07.png?raw=true "Choose options for adding these files prompt") 

### Step 3 

Click on your mobile application's header icon in the Project Navigator to the left. Then choose your mobile application icon under *TARGETS* part of the Project and targets list. Make certain *zoweSDK.framework* is present within *Frameworks, Libraries, and Embedded Content* section at the bottom. If not, click on + to select and add it manually. 

![Zowe SDK in Frameworks, Libraries, and Embedded Content target section](/../screenshots/Scrshots/install/ZoweClientSwiftSDK08.png?raw=true "Zowe SDK in Frameworks, Libraries, and Embedded Content target section") 

### Step 4 

Click on *Build Settings* tab header and scroll to the very bottom. In *Swift Compiler - Search Paths* section, click on the right column of *Import Paths* field, type `$(PROJECT_DIR)/zoweSDK.framework` and press enter. 

![Zowe SDK path in Build Settings/Swift Compiler - Search Paths/Import Paths field](/../screenshots/Scrshots/install/ZoweClientSwiftSDK09.png?raw=true "Zowe SDK path in Build Settings/Swift Compiler - Search Paths/Import Paths field") 

## Using Zowe SDK debug version in your mobile app 

### Step 1 

Click on your mobile application's `ViewController.swift` class in the Project Navogator to the left and start by importing the **zoweSDK** class. 

```swift
import zoweSDK
```

![Import Zowe SDK in your mobile application ViewController class](/../screenshots/Scrshots/install/ZoweClientSwiftSDK10.png?raw=true "Import Zowe SDK in your mobile application ViewController class") 

### Step 2 

Then in `viewDidLoad` method, create an object that will be the handler for all Zowe SDK requests. 

```swift
let z = ZoweSDK(
    zosmfHost: "<host address>", 
    zosmfUser: "<zosmf user>", 
    zosmfPassword: "<zosmf password>")
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
