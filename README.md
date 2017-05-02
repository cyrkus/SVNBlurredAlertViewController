# SVNBlurredAlertViewController
A Blurred Overlay View Controller with a circle mask.
<p align="center">
  <img src="/images/Review.png" alt="SVNBlurredAlertViewController"/>
</p>

# To use this framework
SVNBlurredAlertViewController is intended to be added as a child ViewController it has a
[SVNMaterialButton](https://github.com/sevenapps/SVNMaterialButton) and is a subclass of [SVNModalViewController](https://github.com/sevenapps/SVNModalViewController).
[SVNTheme](https://github.com/sevenapps/SVNTheme)

Use init(theme: model:) or init(nibName: bundleName: theme: model) to instantiate an instance of this class
Either pass in custom SVTheme and SVNBlurredAlertModel instances or nil
If you want to conduct a custom unwind outside of this dismissing itself reference the dismissalCallback: variable.


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
