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
linkNodes()
depthSearch(a, target: i)

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
