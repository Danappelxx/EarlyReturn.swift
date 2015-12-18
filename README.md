# EarlyReturn.swift
A Swift µframework for early return in higher order functions.

```swift
import EarlyReturn

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

# License
The MIT License (MIT)

Copyright (c) 2015 Dan Appel

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
