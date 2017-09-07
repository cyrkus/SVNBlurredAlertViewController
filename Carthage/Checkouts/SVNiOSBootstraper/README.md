 [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

# SVNiOSBootstraper
A bootstaping framework filled with protocols I use all the time.

# Included in this framework:

### Alertable
 A quick way to show stock AlertViewControllers

### KeyboardNotifiable
 Register for keyboard notifications

### Reachable
  Find out if the user has a stable internet connection

### UIDevice
 Get the user's device and version as a Type

### DocumentsSearchable
 Quick helper to look up a file in the documents directory



## To use this framework
Copy and paste the contents (sans .git folder) into a project folder.
To initialize your project for Carthage use and make sure you have Carthage installed:

    bin/setup

Once you've updated the **Cartfile**, to pull down your dependencies call:

    bin/update


## To install this framework

Add Carthage files to your .gitignore

    #Carthage
    Carthage/Build

Check your Carthage Version to make sure Carthage is installed locally:

    Carthage version

Create a CartFile to manage your dependencies:

    Touch CartFile

Open the Cartfile and add this as a dependency. (in OGDL):

    github "sevenapps/PathToRepo*" "master"

Update your project to include the framework:

    Carthage update --platform iOS

Add the framework to 'Embedded Binaries' in the Xcode Project by dragging and dropping the framework created in

    Carthage/Build/iOS/pathToFramework*.framework

Add this run Script to your xcodeproj

    /usr/local/bin/carthage copy-frameworks

Add this input file to the run script:

    $(SRCROOT)/Carthage/Build/iOS/pathToFramework*.framework

If Xcode has issues finding your framework Add

    $(SRCROOT)/Carthage/Build/iOS

To 'Framework Search Paths' in Build Settings
