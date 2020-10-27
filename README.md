# NSResult [![Swift](https://img.shields.io/badge/Swift-5.1-orange.svg?style=flat)](https://developer.apple.com/swift/) ![Platforms](https://img.shields.io/badge/platform-iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS-%23989898)
Objective-C compatible wrapper of Swift's Result type

**Latest release**: 27.10.2020 • version 1.0.0

**Requirements**: iOS 9.0+ • macOS 10.10+ • tvOS 9.0+ • watchOS 2.0+ • Swift 5.1+ / Xcode 11.3+

| Swift version | Project version                                             |
| ------------- | ----------------------------------------------------------- |
| **Swift 5.1** | **v1.0.0**                                                  |

## Table of Contents
* [Usage](#usage)
* [Example](#example)
* [Structure](#structure)
  * [NSResult](#nsresult-class)
  * [StaticMap](#nsresult-staticmap)
  * [Block](#nsresult-block)

## <a name="usage"></a> Usage
#### <a name="usage-carthage"></a> [Carthage](https://github.com/Carthage/Carthage)

**Tested with `carthage version`: `0.36`**

Add this to `Cartfile`

```
git "https://github.com/T1T4N/NSResult.git" ~> 1.0
```

#### [Swift Package Manager](https://github.com/apple/swift-package-manager)

**Tested with `swift build --version`: `Swift Package Manager - Swift 5.3.0`**

```swift
// swift-tools-version:5.1
dependencies: [
    .package(url: "https://github.com/T1T4N/NSResult.git", from: "1.0.0")
]
```

#### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

**Tested with `pod --version`: `1.10.0`**

```ruby
platform :osx, '10.10'
use_frameworks!

target 'MyApp' do
  pod 'NSResultKit', :git => "https://github.com/T1T4N/NSResult.git", :tag => "1.0.0"
end
```

## <a name="example"></a> Example
Check [the example playground](Sources/Example.playground) or the example app in the project.

## <a name="structure"></a> Structure
This is a Swift library meant to be used in mixed-language projects where the codebase still has a considerable amount of Objective-C.

#### <a name="nsresult-class"></a> NSResult
This is a simple `@objc` class that inherits from `NSObject` and has one single property `base: Result<Any, Error>`. This property is only accessible on the Swift side, but `NSResult` can initialized from Objective-C using the following methods:

- `[NSResult success:]`
- `[NSResult failure:]`

#### <a name="nsresult-staticmap"></a> StaticMap
Used on the Swift side to restore type safety to the underlying `Result` object.

#### <a name="nsresult-block"></a> Block
Used on the Objective-C side to cleanly separate the logic for handling a success value from the one for handling a failure.

- `[result performSuccess:^(id _Nonnull value) orFailure:^(NSError * _Nonnull error)]`
- `[result performBlock:^(id _Nullable successValue, NSError * _Nullable failureError)]`
