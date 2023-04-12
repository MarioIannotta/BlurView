![BlurView: Custom blur radius for your UIKit views](https://raw.githubusercontent.com/MarioIannotta/BlurView/main/Resources/BlurView.jpg)

## Why

SwiftUI has an api to blur any view. This package allows to use the same functionality on UIKit views.

## Installation

#### Swift Package Manager
* In Xcode select File > Add Packages.
* Enter this project's URL: https://github.com/MarioIannotta/BlurView.git

## Usage
```swift
import BlurView // import the package

let label = UILabel() 
label.text = "Hi!"

let blurView = BlurView(contentView: label) // instantiate a `BlurView` passing the view you want to blur
blurView.blurRadius = 10 // set a blur radius
```

## Demo
You can find a demo app in the demo folder.

<img src="https://raw.githubusercontent.com/MarioIannotta/BlurView/main/Resources/Demo.gif"/>

## License

BlurView is available under the MIT license. See the LICENSE file for more info.
