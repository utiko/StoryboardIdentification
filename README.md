# StoryboardIdentification

Tool which allows you easy instaniate View Controllers from storyboards with autocomplete. 
Forget about copy-pasting Storyboard IDs, and keeping them up to date in your code.
Autocomplete will show you only view controllers available by ID on specified storyboard.

![](assets/example.png)

## Installation

### Using [CocoaPods](https://cocoapods.org):

1. Add the following line to your Podfile:

```ruby
pod 'StoryboardIdentification'
```

2. Install pod by running

```
pod install
```

3. Add run script pharse above the "Compile Sources" section

```
${PODS_ROOT}/StoryboardIdentification/RefreshStoryboardsData.sh
```

4. Create empty swift file with name **StoryboardIdentifiersUtils.swift** at any place of your project as you wish, e.g. at Utils group.
This file will be automaticaly updated after each storyboard modification.

5. Build

## Usage

Simple create/modify existing storyboards and specify storyboard IDs for View Controllers

Build project.

Now you can instantiacte any view controller in next way:
```swift
let vc = ViewControllerClass.instantiate(from: .storyboardNameStoryboard(.viewControllerID))
```

### Example 
Create **Onboarding.storyboard** 
Add new View Controller, you can specify custom class for example **SignUpViewController**.
Specify storyboard ID: **SignUpViewControllerID**.

Now you can simple call:
```swift
let vc = SignUpViewController.instantiate(from: .onboardingStoryboard(.signUpViewControllerID))
```

If storyboard contains initial view controller, it will be automatically mapped into .initial.

So you can access it by
```swift
let vc = OnboardingStartViewController.instantiate(from: .onboardingStoryboard(.initial))
```

### Result Type
You can get a view controller instance of custom type by specifiing it directly.
Or you can simple call UIViewController.instantiate(...) without specifying concrete type.
If specified type doesn't match real type of View Controller in storyboard, you'll get fatal error.

