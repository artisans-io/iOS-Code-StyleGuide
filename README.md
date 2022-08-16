# iOS-CodeStyleGuide

This document describes design and architecture decisions and agreements for 4.x iOS app.


# Naming conventions

## Protocols and implementations

Use `Type` when naming protocol/implementation for types
```swift
protocol SomeUseCaseType { }

class SomeUseCase: SomeUseCaseType { }
```
> As for now it is mandatory to the SmartApp project, optional for the rest of libs.

## Reactive

:white_check_mark: Use descriptive postfix eg. 
```swift
var statusPublisher: AnyPublisher<String, Never>
``` 
:x: instead of 
```swift
var status: AnyPublisher<String, Never>
```

:white_check_mark: Subscription cancelling
```swift
private var cancellables = Set<AnyCancellable>()
```

# Testing

## Naming tests
Test naming convention is based on [this](https://www.appsdeveloperblog.com/naming-ios-unit-test-methods/)

#### Format
`test_<Condition Or State Change>_<Expected Result>`

#### Example
```swift
test_WhenEmailAndPasswordSet_LoginButtonEnabled()
```

## Timeouts
Testing timeouts are defined in `SmartAppTests` -> `Utils` -> `Consts` and represent the acceptable thresholds i.e `acceptableMinimum` is the timeout we should use for very fast operations in tests that are using the expectations.

#### Usage
```swift
waitForExpectations(timeout: .acceptableMinimum)
```

# Formatting
Most of the stuff should (will) be picked by by formatter but here are some more difficult cases

## Parameters
:white_check_mark: Add line breaks before first parameter when there are multiple parameters
```swift
doSomething(
    param1: "",
    param2: "",
    object: SomeObject(
        property1: "",
        property2: ""
    )
)
``` 
## Other
:x: Do not use self where not needed.
```swift
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.title = lang("workbook_pro.groups_title")
}
```

:white_check_mark: prefer
```swift
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    title = lang("workbook_pro.groups_title")
}
```

:x: Do not use return where not needed.
```swift
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return allGroups.count
}
```

:white_check_mark: prefer
```swift
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    allGroups.count
}
```
