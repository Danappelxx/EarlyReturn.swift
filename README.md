# EarlyReturn.swift
A Swift µframework for early return in higher order functions.

```swift
[1,2,3,4,5].reduce(false) {
    if $1 == 2 { // the array contains a 2
        return .Early(true)
    }
    return .Normal(false)
} // -> true (2 iterations)
```

# Why?
Say you want to get the sum of 5 numbers. Simple:

```swift
[1,2,3,4,5].reduce(0, combine: +)
// iterations: 5
```

Great!

Now, what if you wanted to only take the sum of the first three?

## How it looks like without early return
using filter and reduce

```swift
[1,2,3,4,5].filter { $0 <= 3 }.reduce(0, combine: +)
// iterations: 10
```

or, if you don't want to iterate over the array twice

```swift
[1,2,3,4,5].reduce(0) {
    if $0 <= 3 {
        return $0 + $1
    }
    return $0
}
// iterations: 5
```

or, if you don't want to iterate over the whole array for just the first 3 values

```swift
let arr = [1,2,3,4,5]
var sum = 0
for el in arr {
    if el <= 3 {
        sum += el
        continue
    }
    break
}
// iterations: 3
```

ouch - not so pretty anymore.

## How it looks like with early return

```swift
[1,2,3,4,5].earlyReduce(0) { .EarlyIfTrue($0 == 3, $0 + $1) }
// iterations: 3
```

Much better!

# Supported Return Types
Currently (more coming):
- `Early(Result)`
- `Normal(Result)`
- `EarlyIfTrue(isTrue, Result)`

# Installation
You can use it with the [Swift Package Manager](https://github.com/apple/swift-package-manager)!

# Author
Made by me, Dan Appel, with the help of a few ideas from the [Swift-Lang slack](https://swift-lang.schwa.io).
