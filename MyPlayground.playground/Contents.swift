// Fibonacci dynamically programmed
// 1, 1, 2, 3, 5, 8, 13, 21, 34, 55
// 0, 1, 2, 3, 4, 5, 6,  7,  8,  9

// Simple recursion - Fibonacci
func simpleFib(place: Int) -> Int {
    if (place == 0 || place == 1) {
        return 1
    }
    return simpleFib(place: place - 1) + simpleFib(place: place - 2)
}
//simpleFib(place: 9)

// Top down dynamic programming (Memoization) - Fibonacci
var memo = [Int]()
func memoFib (_ place: Int) -> Int {
    if (memo.count <= place) {
        memo = [Int](repeating: -1, count: place + 1)
        memo[0] = 1
        memo[1] = 1
    }

    if (memo[place] != -1) {
        return memo[place]
    } else {
        memo[place] = memoFib(place - 1) + memoFib(place - 2)
    }
    return memo[place]
}
//memoFib(9)

// Bottom up dynamic programming - Fibonacci
func bottomUp(_ place: Int) -> Int {
    var a = 0
    var b = 1
    var c = a + b

    for _ in 0..<place {
        c = a + b
        a = b
        b = c
    }
    return c
}
//bottomUp(9)

