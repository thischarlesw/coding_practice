import Foundation
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

//var a = Node("a")
//var b = Node("b")
//var c = Node("c")
//var d = Node("d")
//var e = Node("e")
//var f = Node("f")
//var g = Node("g")
//var h = Node("h")
//var i = Node("i")
//var j = Node("j")

//                 a
//              /  |  \
//           b     c   d
//         /  \    |   |
//        e    f   g   h
//             |   |
//             i   j

//func linkNodes() {
//    a.add([b, c, d])
//    b.add([e, f])
//    c.add([g])
//    d.add([h])
//    f.add([i])
//    g.add([j])
//}

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


//[ // a, b, c, d
//    [0, 1, 2, 0], // a
//    [1, 0, 1, 1], // b
//    [2, 1, 0, 3], // c
//    [0, 1, 3, 0]  // d
//]
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

//var sub = "dadvj"
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


//var aL = ListNode(2)
//var bL = ListNode(3)
//var cL = ListNode(5)
//
//var dL = ListNode(1)
//var eL = ListNode(4)
//var fL = ListNode(6)
//
//aL.next = bL
//bL.next = cL
//
//dL.next = eL
//eL.next = fL

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

//var input = [-2,1,-3,4,-1,2,1,-5,4]
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

//var input = [2]
//var input2 = [Int]()
//input = [1,2,3,0,0,0]
//input2 = [2,5,6]
//input = [-1,2,4,5,6,0]
//input2 = [3]
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

func mergeOverlappingIntervals(_ arr: [[Int]]) -> [[Int]] {
    var intervalArray = arr
    intervalArray.sort { (left, right) -> Bool in
        left[0] < right[0]
    }
    var checked = Array(repeating: false, count: intervalArray.count)
    var solution = [[Int]]()
    var groupLow = 0
    var groupHigh = 0
    let arrayCount = intervalArray.count

    for i in 0..<arrayCount {
        groupLow = intervalArray[i][0]
        groupHigh = intervalArray[i][1]

        if (!checked[i]) {
            for j in i..<arrayCount {
                if (intervalArray[j][0] >= groupLow && intervalArray[j][0] <= groupHigh) {
                    groupHigh = intervalArray[j][1] > groupHigh ? intervalArray[j][1] : groupHigh
                    checked[j] = true
                }
            }
            solution.append([groupLow, groupHigh])
            groupLow = 0
            groupHigh = 0
        }
    }
    return solution
}
//var arraysToMerge = [[1, 3], [2, 6], [11, 12], [5, 10]]
//var arraysToMerge = [[1,4], [2,4]]
//var arraysToMerge = [[5,5],[1,3],[3,5],[4,6],[1,1],[3,3],[5,6],[3,3],[2,4],[0,0]]
//mergeOverlappingIntervals(arraysToMerge)

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

// recursion
var listNodes = [ListNode]()
for i in [1,2,3,4] {
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

    for  v in num {
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

// recursion
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
//print(numIslands(islands))

class DoubleLinkedNode {
    var key     : Int!
    var value   : Int!
    var left    : DoubleLinkedNode?
    var right   : DoubleLinkedNode?

    func printNodeValue(_ node: DoubleLinkedNode?) {
        var thisNode = node
        var array = [Int?]()

        while thisNode?.right != nil {
            array.append(thisNode?.value)
            thisNode = thisNode?.right
        }
        print(array)
//        if node?.right != nil {
//            if let value = node?.right?.value {
//                print(value)
//                printNodeValue(node?.right)
//            }
//        }
    }
}

class LRUCache {
    var head        = DoubleLinkedNode()
    var tail        = DoubleLinkedNode()
    var dictionary  = [Int : DoubleLinkedNode]()
    var capacity    = 0
    var nodeCount   = 0

    init(_ capacity: Int) {
        self.capacity = capacity
        head.right = tail
        tail.left = head
    }

    func get(_ key: Int) -> Int {
        var value = -1

        if let node = dictionary[key] {
            value = node.value
            remove(node)
            addToRight(node)
        }
        return value
    }

    func put(_ key: Int, _ value: Int) {
        let node = DoubleLinkedNode()
        node.key    = key
        node.value  = value

        if (!dictionary.keys.contains(key)) {
            nodeCount += 1
            if (nodeCount > capacity) {
                if let actualHead = head.right {
                    dictionary.removeValue(forKey: actualHead.key)
                    remove(actualHead)
                }
                nodeCount -= 1
            }
        } else {
            if let nodeToRemove = dictionary[key] {
                remove(nodeToRemove)
            }
        }
        addToRight(node)
        dictionary[key] = node
    }

    func remove(_ node: DoubleLinkedNode) {
        let nodeLeft = node.left
        let nodeRight = node.right

        nodeLeft?.right = nodeRight
        nodeRight?.left = nodeLeft
    }
    func addToRight(_ node: DoubleLinkedNode) {
        let actualTail      = tail.left

        actualTail?.right   = node
        tail.left           = node

        node.left   = actualTail
        node.right  = tail
    }
}

func isHappy(_ n: Int) -> Bool {
    var slow = n
    var fast = getNext(n)

    while (fast != slow && fast != 1) {
        fast = getNext(getNext(fast))
        slow = getNext(slow)
    }

    return fast == 1
}
func getNext(_ n: Int) -> Int {
    var sum = 0
    var n = n

    while n > 0 {
        let half = n % 10
        n = n / 10
        sum += half * half
    }

    return sum
}
//isHappy(2)

//var prices = [7,1,5,3,6,4] // 5
//prices = [1,2] // 1
func maxProfit(_ prices: [Int]) -> Int {
    if (prices.count == 0) {
        return 0
    }

    var lowest = Int.max
    var maxProfit = 0

    for i in 0..<prices.count {
        if (prices[i] < lowest) {
            lowest = prices[i]
        } else if (prices[i] - lowest > maxProfit) {
            maxProfit = prices[i] - lowest
        }
    }

    return maxProfit
}
//maxProfit(prices)

//var unsortedArray = [9,2,41,12,5,4,78,132]
//func mergeSort(_ array: [Int]) -> [Int] {
//    if (array.count == 0 || array.count == 1) {
//        return array
//    }
//    let leftArray = Array(array[0..<(array.count / 2)])
//    let rightArray = Array(array[(array.count / 2)..<(array.count)])
//
//    return merge(left: mergeSort(leftArray), right: mergeSort(rightArray))
//}
//func merge(left: [Int], right: [Int]) -> [Int] {
//    var solution = [Int]()
//    var left = left
//    var right = right
//
//    while left.count > 0 && right.count > 0 {
//        if (left[0] < right[0]) {
//            solution.append(left.removeFirst())
//        } else {
//            solution.append(right.removeFirst())
//        }
//    }
//    return solution + left + right
//}
//mergeSort(unsortedArray)

class MinBinaryHeap {
    var array = [Int]()

    private func getLeftIndex(_ index: Int) -> Int {
        return index * 2 + 1
    }
    private func getRightIndex(_ index: Int) -> Int {
        return index * 2 + 2
    }
    private func getParentIndex(_ index: Int) -> Int {
        return (index - 1) / 2
    }
    private func hasLeftChild(_ index: Int) -> Bool {
        return getLeftIndex(index) < array.count
    }
    private func hasRightChild(_ index: Int) -> Bool {
        return getRightIndex(index) < array.count
    }
    private func hasParent(_ index: Int) -> Bool {
        return getParentIndex(index) >= 0
    }
    func leftChild(_ index: Int) -> Int {
        if !(hasLeftChild(index)) {
            return -1
        }
        return array[getLeftIndex(index)]
    }
    func rightChild(_ index: Int) -> Int {
        if !(hasRightChild(index)) {
            return -1
        }
        return array[getRightIndex(index)]
    }
    func parent(_ index: Int) -> Int {
        if !(hasParent(index)) {
            return -1
        }
        return array[getParentIndex(index)]
    }

    private func swap(indexOne: Int, indexTwo: Int) {
        let temp = array[indexOne]
        array[indexOne] = array[indexTwo]
        array[indexTwo] = temp
    }

    func getMin() -> Int {
        if (array.count > 0) {
            return array[0]
        }
        return -1
    }
    func removeMin() -> Int {
        if (array.count == 0) {
            return -1
        }
        let root = array[0]
        array[0] = array.removeLast()
        bubbleDown()

        return root
    }
    func add(_ value: Int) {
        array.append(value)
        bubbleUp()
    }
    func bubbleDown() {
        var index = 0
        while hasLeftChild(index) {
            var smallerChild = getLeftIndex(index)
            if (hasRightChild(index) && rightChild(index) < leftChild(index)) {
                smallerChild = getRightIndex(index)
            }
            if (array[index] < array[smallerChild]) {
                break
            } else {
                swap(indexOne: index, indexTwo: smallerChild)
            }
            index = smallerChild
        }
    }
    func bubbleUp() {
        var index = array.count - 1
        while hasParent(index) && parent(index) > array[index] {
            swap(indexOne: index, indexTwo: (index - 1) / 2)
            index = getParentIndex(index)
        }
    }
}
//let min = MinBinaryHeap()
//min.add(3)
//min.add(12)
//min.add(4)
//min.add(9)
//print(min.array)
//min.add(6)
//min.add(2)
//print(min.array)
//min.leftChild(5)

//[
//  1->4->5,
//  1->3->4,
//  2->6
//]
func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
    if (lists.isEmpty) {
        return nil
    }
    if (lists.count == 1) {
        return lists.first as? ListNode
    }

    let left = lists[0..<lists.count / 2]
    let right = lists[(lists.count / 2)..<lists.count]

    return mergeTwoKLists(mergeKLists(Array(left)), mergeKLists(Array(right)))
}
func mergeTwoKLists(_ listOne: ListNode?, _ listTwo: ListNode?) -> ListNode? {
    var current = ListNode(0)
    let head = current
    var currentOne = listOne
    var currentTwo = listTwo

    while currentOne != nil && currentTwo != nil {
        if currentOne!.val < currentTwo!.val {
            current.next = currentOne
            current = current.next!
            currentOne = currentOne!.next
        } else {
            current.next = currentTwo
            current = current.next!
            currentTwo = currentTwo?.next
        }
    }
    if currentOne == nil {
        current.next = currentTwo
    } else if currentTwo == nil {
        current.next = currentOne
    }
    return head.next
}
//1->1->2->3->4->4->5->6

let rotatedArray = [1,2,3]
let rotatedTarget = 0
func rotatedSearch(_ nums: [Int], _ target: Int) -> Int {
    let index = findRotationIndex(nums, 0, nums.count-1)
    if (index == -1) {
        return -1
    }

    if (target < nums[0]) {
        return binarySearch(nums, target, index+1, nums.count)
    } else {
        return binarySearch(nums, target, 0, index)
    }
}
func findRotationIndex(_ nums: [Int], _ left: Int, _ right: Int) -> Int {
    let mid = (left + right) / 2

    if (left > right) {
        return -1
    }
    if (nums[left] < nums[right-1] || mid+1 >= nums.count) {
        return 0
    }

    if (nums[mid] > nums[mid+1]) {
        return mid
    } else if (nums[left] > nums[mid]) {
        return findRotationIndex(nums, left, mid-1)
    } else {
        return findRotationIndex(nums, mid+1, right)
    }
}
func binarySearch(_ nums: [Int], _ target: Int, _ left: Int, _ right: Int) -> Int {
    if (left > right || nums.count == 0) {
        return -1
    }

    let mid = (left+right)/2
    if (target < nums[mid]) {
        return binarySearch(nums, target, left, mid-1)
    } else if (target > nums[mid]) {
        return binarySearch(nums, target, mid+1, right)
    } else {
        return mid
    }
}
//findRotationIndex([3,4,1], 0, 3)
//print(rotatedSearch(rotatedArray, rotatedTarget))

// O(1) to add and remove
class RandomizedSet {
    var items = [Int]()         // [value]
    var dict = [Int : Int]()    // [value : index]

    init() {

    }
    /** Inserts a value to the set. Returns true if the set did not already contain the specified element. */
    func insert(_ val: Int) -> Bool {
        if let _ = dict[val] {
            return false
        } else {
            items.append(val)
            dict[val] = items.count - 1

            return true
        }
    }

    /** Removes a value from the set. Returns true if the set contained the specified element. */
    func remove(_ val: Int) -> Bool {
        if let i = dict[val] {
            let itemToRemove    = items[i]
            let itemLast        = items.last!

            items[i] = itemLast
            items.removeLast()
            dict[itemLast] = i
            dict.removeValue(forKey: itemToRemove)
            return true
        } else {
            return false
        }
    }

    /** Get a random element from the set. */
    func getRandom() -> Int {
        return items.randomElement()!
    }
}
//let rSet = RandomizedSet()
//rSet.insert(1)
//rSet.insert(0)
//rSet.remove(0)

// recursion
var permutations = [[Int]]()
func permutations(_ array: [Int]) -> [[Int]] {
    addPermutations(array, [])
    return permutations
}
func addPermutations(_ digits: [Int], _ saved: [Int]) {
    if (digits.isEmpty) {
        permutations.append(saved)
    }
    for i in 0..<digits.count {
        var remainder = digits
        let current = remainder.remove(at: i)
        addPermutations(remainder, saved + [current])
    }
}
//print(permutations([1,2,3]))

//let s = "leetcode"
//let wordDict = ["leet", "code"]
//let s = "aabbcc"
//let wordDict = ["aa", "bb", "cc"]
let s = "catsandog"
let wordDict = ["cats", "dog", "sand", "and", "cat"]
// recursion
func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
    return wordBreakCheck(s, wordDict, 0)
}
func wordBreakCheck(_ s: String, _ wordDict: [String], _ start: Int) -> Bool {
    if (start == s.count) {
        return true
    }
    for i in 0..<s.count {
        let prefix = String(Array(s)[0..<i])
        let suffix = String(Array(s)[i..<s.count])

        if (wordDict.contains(prefix) && wordBreakCheck(suffix, wordDict, i)) {
            return true
        }
    }
    return false
}
//print(wordBreak(s, wordDict))


let beginWord = "hit"
let endWord = "cog"
let wordList = ["hot","dot","dog","lot","log","cog"]
func generateNodes(_ wordDict: [String]) -> [String : [String]] {
    var stringLink = [String : [String]]()

    for word in wordDict {
        var stringStars = [String]()
        for (i,_) in word.enumerated() {
            var starWord = Array(word)
            starWord[i] = "*"
            stringStars.append(String(starWord))
        }
        stringLink[String(word)] = stringStars
    }

    return stringLink
}
func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
    let nodeDict = generateNodes(wordList)
//    print(nodeDict)
    let keys: [String] = Array(nodeDict.keys)
    let falseArray = Array(repeating: false, count: keys.count)
    var visited: [String : Bool] = Dictionary(uniqueKeysWithValues: zip(keys, falseArray))
    var visits = 0

    let q = Queue()
    q.add(beginWord)
    visited[beginWord] = true

//    print(visited)
    while !q.isEmpty() {
        let word = q.dequeue() as! String
        print(word)
        print(nodeDict)
        let linkedWords = nodeDict[word]

        if (word == endWord) {
            return visits
        }

        for w in linkedWords! {
            if (!visited[w]!) {
                visits += 1
                visited[w]! = true
                q.add(w)
            }
        }
    }


    return visits
}
//ladderLength(beginWord, endWord, wordList)

//Input:  [1,2,3,4]
//Output: [24,12,8,6]
func productExceptSelf(_ nums: [Int]) -> [Int] {
    var leftWay: [Int] = Array(repeating: 1, count: nums.count)
    var rightWay: [Int] = Array(repeating: 1, count: nums.count)
    var solution: [Int] = Array(repeating: 1, count: nums.count)

    for (i,v) in nums.enumerated() {
        if (i < nums.count-1) {
            leftWay[i+1] = v * leftWay[i]
        }
    }
    let reversed = nums.reversed()
    for (i,v) in reversed.enumerated() {
        if (i < nums.count-1) {
            rightWay[i+1] = v * rightWay[i]
        }
    }
    rightWay = rightWay.reversed()

    for (i,_) in nums.enumerated() {
        solution[i] = leftWay[i] * rightWay[i]
    }

    return solution
}
//productExceptSelf([4,5,1,8,2])

// Rotted orange is 2, rots neighbor once a turn
// return turns to full rot or -1 if there is a fresh
var orangeArray = [[2,1,1],[1,1,0],[0,1,1]]
func orangesRotting(_ tray: [[Int]]) -> Int {
    var turns = 0

    var check = checkRot(tray)
    while check.0 {
        check = checkRot(check.1)
        turns += 1
    }

    for row in check.1 {
        for v in row {
            if (v == 1) {
                turns = -1
            }
        }
    }

    return turns
}
func checkRot(_ tray: [[Int]]) -> (Bool, [[Int]]) {
    var tray = tray
    var willRot = [[Int]]()
    var isDone = true

    for (i,row) in tray.enumerated() {
        for (j,v) in row.enumerated() {
            if (v == 2) {
                if (orangeInTray(tray, i+1, j) && tray[i+1][j] == 1) {
                    willRot.append([i+1, j])
                }
                if (orangeInTray(tray, i-1, j) && tray[i-1][j] == 1) {
                    willRot.append([i-1, j])
                }
                if (orangeInTray(tray, i, j+1) && tray[i][j+1] == 1) {
                    willRot.append([i, j+1])
                }
                if (orangeInTray(tray, i, j-1) && tray[i][j-1] == 1) {
                    willRot.append([i, j-1])
                }
            }
        }
    }

    if (willRot.isEmpty) {
        isDone = false
    } else {
        for v in willRot {
            tray[v[0]][v[1]] = 2
        }
    }

    print(isDone)
    print(tray)
    return (isDone, tray)
}
func orangeInTray(_ tray: [[Int]], _ i: Int, _ j: Int) -> Bool {
    return (i >= 0 && i < tray.count && j >= 0 && j < tray[i].count )
}
//orangesRotting([[1,0,0],[0,0,0],[1,1,0]])

// Array of coins, min coins to make target amount
// recursion
var count = [Int : Int]()
func coinChange(_ coins: [Int], _ amount: Int) -> Int {
    if (amount < 1) { return 0 }
    return cChange(coins, amount)
}
func cChange(_ coins: [Int], _ remainder: Int) -> Int {
    if (remainder < 0) { return -1 }
    if (remainder == 0) { return 0 }
    if let v = count[remainder-1] {
        return v
    }
    var min = Int.max
    for coin in coins {
        let newRemainder = coinChange(coins, remainder-coin)

        if (newRemainder < min && newRemainder >= 0) {
            min = newRemainder + 1
        }
        count[remainder-1] = (min == Int.max) ? -1 : min
//        print(remainder)
//        print(count)
    }

    return count[remainder-1]!
}
//coinChange([1,2,5], 11)
//coinChange([2], 3)
