# OceanHero iOS

## Building

### Submodules
We use submodules, so you will need to bring them into the project in order to build and run it:

Run `git submodule update --init --recursive`

### Dependencies
We use Carthage for dependency management. If you don't have Carthage installed refer to [Installing Carthage](https://github.com/Carthage/Carthage#installing-carthage).

Run `carthage bootstrap --platform iOS` before opening the project in Xcode

You can also run the unit tests to do the above and ensure everything seems in order: `./run_tests.sh`

### SwiftLint
We use [SwifLint](https://github.com/realm/SwiftLint) for enforcing Swift style and conventions, so you'll need to [install it](https://github.com/realm/SwiftLint#installation).

## Discussion

Ocean Hero browser is builded on top of DuckDuckGo implementation. Because it's builded on already working app, not a framework, there is no easy way to update it. We need to treat Ocean Hero as separated project from now on.

## Contact 

In case of any questions please contact me on cezary.bielecki@digitalforms.pl
