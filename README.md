# Marvel Heros 

This project is based on [Xcodegen](https://github.com/yonaskolb/XcodeGen), so any `xcworkspace` and `xcodeproj` files are generated and used only locally.

## Prerequisites

Install Xcodegen: 

```
brew install xcodegen
```

## Easy way

A submission branch has been added where the gitignor has been deleted and all files including project files have been comitted

## Generating Xcode Project Files

To generate the project files, use `xcodegen generate` from within the root directory. This will generate a `xcworkspace`s and a `xcodeproj` file. You're going to want to open the project using the `xcworkspace` file.

With the following command the project file is completely regenerated and then opened:

```
find *.xc* -type f -not -name 'Package.resolved' -delete && xcodegen && (open *.xcworkspace || open *.xcodeproj)
```
