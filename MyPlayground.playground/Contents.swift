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

class Node {
    var value   : String
    var nodes   = [Node]()
    var visited = false

    init(_ value: String) {
        self.value = value
    }
    func add(_ nodeArray: [Node]) {
        nodes = nodeArray
    }
}
class BinaryNode {
    var value       : String
    var leftNode    : BinaryNode?
    var rightNode   : BinaryNode?

    init(_ value: String) {
        self.value = value
    }
}
class Queue {
    var array = [Any]()

    func values() -> [Any] {
        var arr = [String]()
        for index in array {
            arr.append((index as! Node).value)
        }
        return arr
    }
    func add(_ obj: Any) {
        array.append(obj)
    }
    func dequeue() -> Any? {
        if (!array.isEmpty) {
            return array.removeFirst()
        }
        return nil
    }
    func isEmpty() -> Bool {
        array.isEmpty
    }
}

var a = Node("a")
var b = Node("b")
var c = Node("c")
var d = Node("d")
var e = Node("e")
var f = Node("f")
var g = Node("g")
var h = Node("h")
var i = Node("i")
var j = Node("j")

//                 a
//              /  |  \
//           b     c   d
//         /  \    |   |
//        e    f   g   h
//             |   |
//             i   j

func linkNodes() {
    a.add([b, c, d])
    b.add([e, f])
    c.add([g])
    d.add([h])
    f.add([i])
    g.add([j])
}

// Depth first search
func depthSearch(_ root: Node, target: Node) -> Node? {
    root.visited = true
    if (root.value == target.value) {
        print("found: \(root.value)")
        return root
    }

    for node in root.nodes {
        if (node.visited == false) {
            print("Searching: \(node.value)")
            if let looking = depthSearch(node, target: target) {
                return looking
            }
        }
    }
    return nil
}
//linkNodes()
//depthSearch(a, target: i)

// Breadth first search
func breadthSearch(_ root: Node, target: Node) -> Node? {
    var found: Node?

    let q = Queue()
    root.visited = true
    q.add(root)

    while !q.isEmpty() {
//        print(q.values())
        let newRoot = q.dequeue() as! Node
        if (newRoot.value == target.value) {
            found = newRoot
            break
        }
        for node in newRoot.nodes {
            if (!node.visited) {
                node.visited = true
                q.add(node)
            }
        }
    }
    return found
}
//linkNodes()
//breadthSearch(a, target: g)


[ // a, b, c, d
    [0, 1, 2, 0], // a
    [1, 0, 1, 1], // b
    [2, 1, 0, 3], // c
    [0, 1, 3, 0]  // d
]
//  a - b
//  |     \
//    /    d
//  |     /
//  c - -


class ListNode {
    public var val: Int
    public var next: ListNode?

    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

var sub = "dadvj"
//var sub = "aab"
//var sub = "pwwkew"
//var sub = "bbbb"
//var sub = "abcabcbb"
// TODO: Study again
func longestNonRepeating(_ s: String) -> Int {
    let sLength = s.count
    let string = Array(s)
    var characters = [Character]()
    var length = 0
    var left = 0
    var right = 0

    while (left < sLength && right < sLength) {
        if (!characters.contains(string[right])) {
            characters.append(string[right])
            right += 1
            if (right - left > length) {
                length = right - left
            }
        } else {
            characters.remove(at: 0)
            left += 1
        }
    }

    return length
}
//longestNonRepeating(sub)

func isPalindrome(_ s: String) -> Bool {
    var isPalindrome = true
    let stringArray = Array(s)

    for c in 0..<(stringArray.count / 2) {
        if (isPalindrome) {
            isPalindrome = (stringArray[c] == stringArray[stringArray.count - 1 - c])
        }
    }
    return isPalindrome
}
//isPalindrome("bba")
func longCheck(_ s: String) -> String {
    var hasPalindrome = false
    let stringArray = Array(s)
//    let sReversed = s.reversed()
    var count = 0
    var palin = ""

    for cOne in 0..<stringArray.count {
        for cTwo in cOne..<stringArray.count {
            let shortString = stringArray[cOne...cTwo]
            if (isPalindrome(String(shortString))) {
                if (shortString.count > count) {
                    count = shortString.count
                    palin = String(shortString)
                }
            }
        }
    }
    return palin
}
//longCheck("daccab")
//var testCharacters: [Character] = ["C", "h", "a", "r", "l", "e", "s"]
//print(String(testCharacters))

func getSingleNumber(_ c: String) -> Int {
    switch c {
    case "I":
        return 1
    case "V":
        return 5
    case "X":
        return 10
    case "L":
        return 50
    case "C":
        return 100
    case "D":
        return 500
    case "M":
        return 1000
    default:
        return 0
    }
}
func romanToInt(_ s: String) -> Int {
    let stringArray = Array(s)
    var numberDict = [Int : [Any]]() // index : [value, visit]
    var value = 0

    for (index, c) in stringArray.enumerated() {
        numberDict[index] = [getSingleNumber(String(c)), false]
    }

    let total = numberDict.count
    for index in 0..<total {
        let firstVisit = numberDict[index]![1] as! Bool
        let firstValue = numberDict[index]![0] as! Int

        if (!firstVisit) {
            print(firstVisit)
            if let secondVisit = numberDict[index + 1]?[1] as? Bool, let secondValue = numberDict[index + 1]?[0] as? Int, firstValue < secondValue, !secondVisit {
                value += secondValue - firstValue
                numberDict[index + 1]![1] = true
            } else {
                value += firstValue
            }
            numberDict[index]![1] = true
        }
    }
    return value
}
//romanToInt("VC")

class StringStack {
    var array = [String]()

    func push(_ s: String) {
        array.append(s)
    }
    func pop() -> String? {
        return array.popLast()
    }
}
func isValidParentheses(_ s: String) -> Bool {
    let stringArray = Array(s)
    let stack = StringStack()

    for c in stringArray {
        switch String(c) {
        case "(", "{", "[":
            stack.push(String(c))
        case ")":
            let last = stack.pop()
            if (last != "(") {
                return false
            }
        case "}":
            let last = stack.pop()
            if (last != "{") {
                return false
            }
        case "]":
            let last = stack.pop()
            if (last != "[") {
                return false
            }
        default:
            print("Nothing")
        }
    }
    if (stack.array.isEmpty) {
        return true
    } else {
        return true
    }
}
//isValidParentheses("({)[}]")


var aL = ListNode(2)
var bL = ListNode(3)
var cL = ListNode(5)

var dL = ListNode(1)
var eL = ListNode(4)
var fL = ListNode(6)

aL.next = bL
bL.next = cL

dL.next = eL
eL.next = fL

func print(node: ListNode?) {
    if let node = node {
        print(node.val)
        print(node: node.next)
    }
    return
}
func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var nextA       : ListNode?
    var nextB       : ListNode?
    var startNode   : ListNode?
    var currentNode : ListNode?

    if let l1 = l1, let l2 = l2 {
        if (l1.val <= l2.val) {
            startNode = l1
            nextA = l1.next
            nextB = l2
        } else {
            startNode = l2
            nextB = l2.next
            nextA = l1
        }
        currentNode = startNode
    } else if let l1 = l1 {
        startNode = l1
    } else if let l2 = l2 {
        startNode = l2
    }

    while (nextA != nil && nextB != nil) {
        if let nexta = nextA, let nextb = nextB {
            if (nexta.val <= nextb.val) {
                currentNode?.next = nexta
                nextA = nexta.next
            } else {
                currentNode?.next = nextb
                nextB = nextb.next
            }
            currentNode = currentNode?.next
        }
    }
    if let nextA = nextA {
        currentNode?.next = nextA
    } else if let nextB = nextB {
        currentNode?.next = nextB
    }
    return startNode
}
//let start = mergeTwoLists(aL, dL)
//print(start)
func mergeTwoListsRecursive(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    if (l1 == nil) {
        return l2
    } else if (l2 == nil) {
        return l1
    } else if (l1!.val < l2!.val) {
        l1!.next = mergeTwoListsRecursive(l1!.next, l2)
        return l1
    } else {
        l2!.next = mergeTwoListsRecursive(l1, l2!.next)
        return l2
    }
}
//let secondStart = mergeTwoListsRecursive(aL, dL)
//print(secondStart)

var boardSize = 8
var colMoves = [2, 2, -2, -2, 1, 1, -1, -1]
var rowMoves = [1, -1, 1, -1, 2, -2, 2, -2]
var col = Array(repeatElement(0, count: boardSize))
var board = Array(repeatElement(col, count: boardSize))
//board[0][0] = 1
//print(board)
func solveKnight(_ moveCount: Int, col: Int, row: Int) -> Bool {
    if (moveCount == boardSize * boardSize) {
        return true
    }
    for move in 0..<colMoves.count {
        let nextCol = col + colMoves[move]
        let nextRow = row + rowMoves[move]

        if (isValidMove(col: nextCol, row: nextRow) && board[nextCol][nextRow] == 0) {
            board[nextCol][nextRow] = moveCount
            if (solveKnight(moveCount + 1, col: nextCol, row: nextRow)) {
                return true
            }
        } else if (isValidMove(col: nextCol, row: nextRow)) {
            board[nextCol][nextRow] = 0
        }
    }

    return false
}
func isValidMove(col: Int, row: Int) -> Bool {
    return (col >= 0 && col < boardSize && row >= 0 && row < boardSize)
}
//board[0][0] = 1
//solveKnight(2, col: 0, row: 0)
//print(board)

var input = [-2,1,-3,4,-1,2,1,-5,4]
func maxSubArraySum(_ nums: [Int]) -> Int {
    var currentSum = nums[0]
    var maxSum = nums[0]

    for i in 1..<nums.count {
        let value = nums[i]
        currentSum = value > (currentSum + value) ? value : (currentSum + value)
        maxSum = maxSum > currentSum ? maxSum : currentSum
    }

    return maxSum
}
//maxSubArraySum(input) // 6

input = [4, 5, 6, 0, 0, 0]
var input2 = [1, 2, 3]
//input = [2]
//input2 = [Int]()
//input = [1,2,3,0,0,0]
//input2 = [2,5,6]
input = [-1,2,4,5,6,0]
input2 = [3]
func mergeSortedArrays(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    var h1 = 0
    var h2 = 0
    var nums11 = nums1
    var nums2 = nums2
    var solution: [Int?] = Array(repeating: nil, count: m + n)

    for i in 0..<solution.count {
        print(solution)
        if (nums11.isEmpty && nums2.isEmpty) {
            break
        } else if (nums11.isEmpty) {
            solution[i] = nums2.remove(at: 0)
            h2 += 1
        } else if (nums2.isEmpty) {
            solution[i] = nums11.remove(at: 0)
            h1 += 1
        } else if (nums11[0] < nums2[0] && nums11[0] != 0) {
            let remove = nums11.remove(at: 0)
            print("d \(h1)    \(remove)")
            solution[i] = remove
            h1 += 1
        } else {
            let remove = nums2.remove(at: 0)
            print("e \(h2)    \(remove)")
            solution[i] = remove
            h2 += 1
        }
    }
    nums1 = [Int]()
    for v in solution {
        nums1.append(v!)
    }
}
//mergeSortedArrays(&input, 5, input2, 1)
//print(input)

func mergeOverlaps(_ arr: [[Int]]) -> [[Int]] {
    var sorted = arr
    var mergeable = [[Int]]()

    sorted = sorted.sorted { (left, right) -> Bool in
        left[0] < right[0]
    }
    let staticSort = sorted

    var group = [Int]()
    var indexTracker = 0
    while !sorted.isEmpty {
        for (i, interval) in sorted.enumerated() {
            if (i + 1 < sorted.count) {
                if (interval[1] > sorted[i + 1][0]) {
                    if (!group.contains(i)) {
                        group.append(i)
                    }
                    group.append(i + 1)
                }
            } else if (sorted.count == 1) {
                group.append(indexTracker)
            }
        }
        mergeable.append(group)

        for _ in 0..<group.count {
            sorted.remove(at: 0)
            indexTracker += 1
        }
        group.removeAll()
    }
    return combineGroups(staticSort, mergeable)
}
func combineGroups(_ arr: [[Int]], _ groups: [[Int]]) -> [[Int]] {
    var lowestInGroup: Int
    var highestInGroup: Int
    var mergedInterval = [[Int]]()

    for group in groups {
        let firstInterval = group[0]
        lowestInGroup = arr[firstInterval][0]
        highestInGroup = arr[firstInterval][1]

        for interval in group {
            let low = arr[interval][0]
            let high = arr[interval][1]

            if (low < lowestInGroup) {
                lowestInGroup = low
            }
            if (high > highestInGroup) {
                highestInGroup = high
            }
        }

        mergedInterval.append([lowestInGroup, highestInGroup])
    }

    return mergedInterval
}

//var arraysToMerge = [[1, 3], [2, 6], [11, 12], [5, 10]]
//var arraysToMerge = [[1,3], [2,6], [8,10], [15,18]]
//combineGroups(arraysToMerge, [[0, 1], [2], [3]])
//mergeOverlaps(arraysToMerge)

let wordBoard: [[Character]] = [
    ["A","B","C","E"],
    ["S","F","C","S"],
    ["A","D","E","E"]
]
let target = "ABCCED"
var visitedWordBoard = [[Bool]]()
func wordExistsIn(in board: [[Character]], _ word: String) -> Bool {
    let targetChars = Array(word)
    let rows = board.count
    let columns = board[0].count

    visitedWordBoard = Array(repeating: Array(repeating: false, count: columns), count: rows)
    for r in 0..<rows {
        for c in 0..<columns {
            if (board[r][c] == targetChars[0] && recursive4Search(0, r, c, board, targetChars)) {
                return true
            }
        }
    }
    return false
}
func recursive4Search(_ index: Int, _ row: Int, _ col: Int, _ board: [[Character]], _ target: [Character]) -> Bool {
    if (index == target.count) {
        return true
    }
    if (row < 0 || row > board.count - 1 ||
        col < 0 || col > board[row].count - 1 ||
        board[row][col] != target[index] ||
        visitedWordBoard[row][col]) {
        return false
    }
    visitedWordBoard[row][col] = true
    if (recursive4Search(index + 1, row + 1, col, board, target) ||
        recursive4Search(index + 1, row - 1, col, board, target) ||
        recursive4Search(index + 1, row, col + 1, board, target) ||
        recursive4Search(index + 1, row, col - 1, board, target)) {
        return true
    }
    visitedWordBoard[row][col] = false
    return false
}
//print((wordExistsIn(in: wordBoard, target)))

var listNodes = [ListNode]()
for i in [8,8,8,8] {
    listNodes.append(ListNode(i))
}
for (i, node) in listNodes.enumerated() {
    if (i != listNodes.count - 1) {
        node.next = listNodes[i + 1]
    }
}
//print(node: listNodes[0])
func reverseListNode(_ node: ListNode?) -> ListNode? {
    if (node == nil || node?.next == nil) {
        return node
    }
    let n = reverseListNode(node?.next)
    node?.next?.next = node
    node?.next = nil
    return n
}
//print(node: reverseListNode(listNodes[0]))

func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var next1 = l1
    var next2 = l2
    var current = ListNode(0)
    let head = current
    var carry = 0

    while (next1 != nil || next2 != nil) {
        var sum = (next1?.val ?? 0) + (next2?.val ?? 0) + carry
        carry = sum / 10
        sum = sum % 10

        current.next = ListNode(sum)
        current = current.next!

        next1 = next1?.next
        next2 = next2?.next
    }
    if (carry != 0) {
        current.next = ListNode(carry)
    }
    return head.next
}
// 8888 + 888
//print(node: addTwoNumbers(listNodes[0], listNodes[1]))

func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var dictionary = [Int : Int]() // value : index

    for (i, v) in nums.enumerated() {
        let diff = target - v
        if (dictionary.keys.contains(diff)) {
            return [i, dictionary[diff]!]
        }
        dictionary[v] = i
    }

    return [Int]()
}
//var threeSumArray = [-1, 0, 1, 2, -1, -4]
var threeSumArray = [1,2,-2,-1]
func threeSum(_ num: [Int], _ target: Int) -> [[Int]] {
    var solution = [[Int]]()

    if (num.count < 3) {
        return solution
    }

    for (i, v) in num.enumerated() {
        let twoSumIndex = twoSum(num, -v)
        if (twoSumIndex.count > 0) {
            var three = [
                v,
                num[twoSumIndex[0]],
                num[twoSumIndex[1]]
            ]
            print("target \(-v) \(twoSumIndex) \(three)")
            three.sort()
            if (!solution.contains(three)) {
                solution.append(three)
            }
        }
    }

    return solution
}
//print(threeSum(threeSumArray, 0))
//[
//  [-1, 0, 1],
//  [-1, -1, 2]
//]
// []
var islands: [[Character]] = [
    ["1","1","1","1","0"],
    ["1","1","0","0","0"],
    ["1","0","1","0","0"],
    ["0","0","0","1","1"]
]
func numIslands(_ grid: [[Character]]) -> Int {
    var checkGrid = grid
    var count = 0

    for row in 0..<checkGrid.count {
        for col in 0..<checkGrid[row].count {
            if (checkGrid[row][col] == Character("1")) {
                count += 1
                checkGrid = checkIslandBorder(row, col, checkGrid)
            }
        }
    }

    return count
}
func checkIslandBorder(_ row: Int, _ col: Int, _ grid: [[Character]]) -> [[Character]] {
    var checkGrid = grid

    if (row < 0 || row >= grid.count || col < 0 || col >= grid[row].count || grid[row][col] == Character("0")) {
        return checkGrid
    }
    checkGrid[row][col] = Character("0")
    checkGrid = checkIslandBorder(row + 1, col, checkGrid)
    checkGrid = checkIslandBorder(row - 1, col, checkGrid)
    checkGrid = checkIslandBorder(row, col + 1, checkGrid)
    checkGrid = checkIslandBorder(row, col - 1, checkGrid)

    return checkGrid
}
print(numIslands(islands))
