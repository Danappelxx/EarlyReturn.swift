let arr = [1,2,3,4,5]

// sum of all elements
let val1 = arr.reduce(0, combine: +)

// sum of all elements up to 3 (inclusive)
let val2 = arr.earlyReduce(0) { .EarlyIfTrue($1 == 3, $0 + $1) }

print("normal: \(val1)") // 1+2+3+4+5 -> 15
print("early: \(val2)") // 1+2+3 -> 6
