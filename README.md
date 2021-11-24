# OceanHero iOS

Download on the [App Store](https://apps.apple.com/us/app/oceanhero-browser/id1536398518).

This branch (main)
-----------

This branch works with [Xcode 12.1](https://developer.apple.com/services-account/download?path=/Developer_Tools/Xcode_12.1/Xcode_12.1.xip), Swift 5.2 and supports iOS 12.0 and above.

Please make sure you aim your pull requests in the right direction.

For bug fixes and features for a specific release use the version branch.

Getting involved
----------------

Want to contribute but don't know where to start? Here is a list of [issues that are contributor friendly](https://github.com/oceanherosearch/oceanhero-ios-app/issues)

Building the code
-----------------

1. Install the latest [Xcode developer tools](https://developer.apple.com/xcode/downloads/) from Apple.
1. Install Carthage and Node
    ```shell
    brew update
    brew install carthage
    brew install node
    ```
1. Clone the repository:
    ```shell
    git clone -b qwant-3.0-v30 --single-branch https://github.com/oceanherosearch/oceanhero-ios-app.git
    ```
1. Pull in the project dependencies:
    ```shell
    cd oceanhero-ios
    sh ./bootstrap.sh
    ```
1. Open `Client.xcodeproj` in Xcode.
1. Build the `Fennec` scheme in Xcode.

## Building User Scripts

User Scripts (JavaScript injected into the `WKWebView`) are compiled, concatenated and minified using [webpack](https://webpack.js.org/). User Scripts to be aggregated are placed in the following directories:

```
/Client
|-- /Frontend
    |-- /UserContent
        |-- /UserScripts
            |-- /AllFrames
            |   |-- /AtDocumentEnd
            |   |-- /AtDocumentStart
            |-- /MainFrame
                |-- /AtDocumentEnd
                |-- /AtDocumentStart
```

This reduces the total possible number of User Scripts down to four. The compiled output from concatenating and minifying the User Scripts placed in these folders resides in `/Client/Assets` and are named accordingly:

* `AllFramesAtDocumentEnd.js`
* `AllFramesAtDocumentStart.js`
* `MainFrameAtDocumentEnd.js`
* `MainFrameAtDocumentStart.js`

To simplify the build process, these compiled files are checked-in to this repository. When adding or editing User Scripts, these files can be re-compiled with `webpack` manually. This requires Node.js to be installed and all required `npm` packages can be installed by running `npm install` in the root directory of the project. User Scripts can be compiled by running the following `npm` command in the root directory of the project:

```
npm run build
```
