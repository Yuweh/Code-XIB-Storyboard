# Code-XIB-Storyboard

[![forthebadge](http://forthebadge.com/images/badges/made-with-swift.svg)](http://forthebadge.com) [![forthebadge](http://forthebadge.com/images/badges/built-with-love.svg)](http://forthebadge.com)

There has been a heated debate in the Swift community regarding the use of storyboard and programmatic when it comes to creating your interface. This Repo will explore the bounderies, ProS and ConS, and fitting application of each UI-approach.

Code vs XIB vs Storyboard
Sample UI: Twitter


## Project Setup

A common question when beginning an iOS project is whether to write all views in code or use Interface Builder with Storyboards or XIB files. Both are known to occasionally result in working software. However, there are a few considerations:


### Launchscreen Guide

iPhoneX Portraint - 1125px × 2436px
iPhone Portrait iOS 8,9
Retina HD 5.5 (iPhone 6 Plus) - 1242px x 2208px - Default-736h@3x.png
Retina HD 4.7 (iPhone 6) - 750px x 1334px - Default-667h@2x.png
iPhone Landscape iOS 8,9
Retina HD 5.5 (iPhone 6 Plus) - 2208px x 1242px - Default-Landscape-736h@3x.png
iPhone Portrait iOS 7-9
2x (iPhone 4) - 640px x 960px - Default@2x.png
Retina 4 (iPhone 5) - 640px x 1136px - Default-568h@2x.png
iPhone Portrait iOS 5,6
1x (iPhone 3) - 320px x 480px - Default.png
2x (iPhone 4) - 640px x 960px - Default@2x.png
Retina 4 (iPhone 5) - 640px x 1136px - Default-568h@2x.png

ref:

https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/launch-screen/


## Why code?

Storyboards are more prone to version conflicts due to their complex XML structure. This makes merging much harder than with code.

It's easier to structure and reuse views in code, thereby keeping your codebase DRY.

All information is in one place. In Interface Builder you have to click through all the inspectors to find what you're looking for.

Storyboards introduce coupling between your code and UI, which can lead to crashes e.g. when an outlet or action is not set up correctly. These issues are not detected by the compiler.

## Why Storyboards?

For the less technically inclined, Storyboards can be a great way to contribute to the project directly, e.g. by tweaking colors or layout constraints. However, this requires a working project setup and some time to learn the basics.
Iteration is often faster since you can preview certain changes without building the project.
Custom fonts and UI elements are represented visually in Storyboards, giving you a much better idea of the final appearance while designing.

For size classes, Interface Builder gives you a live layout preview for the devices of your choice, including iPad split-screen multitasking.

## Why not both?

To get the best of both worlds, you can also take a hybrid approach: Start off by sketching the initial design with Storyboards, which are great for tinkering and quick changes. You can even invite designers to participate in this process. As the UI matures and reliability becomes more important, you then transition into a code-based setup that's easier to maintain and collaborate on.
