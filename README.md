# StoryboardIdentification

Tool which allows you easy acceess your storyboards and instaniate view controllers by autoupdated constants

## Installation

### Using [CocoaPods](https://cocoapods.org):

Add the following line to your Podfile:

```ruby
pod 'StoryboardIdentification'
```

Install pod by running

```
pod install
```

Add run script pharse above the "Compile Sources" section

```
${PODS_ROOT}/StoryboardIdentification/RefreshStoryboardsData.sh
```

Create empty swift file with name *StoryboardIdentifiersUtils.swift* at Utils group or at ny other place of your project.
This file will be automaticaly updated after each storyboard modification.
