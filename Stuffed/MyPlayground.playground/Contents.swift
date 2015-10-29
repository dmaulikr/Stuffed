
import UIKit
import SpriteKit

public enum Names: String {
    
    case Fireball, Pixel
    
}



// Overload the ~= operator to match a string with an integer
func ~=(pattern: SKPhysicsContact , value: Names) -> Bool {
    return pattern.bodyA.node?.name == value.rawValue && pattern.bodyB.node?.name == value.rawValue
}

let bodya = SKPhysicsBody()
bodya.node?.name = Names.Fireball.rawValue

let bodyb = SKPhysicsBody()
bodyb.node?.name = Names.Fireball.rawValue

let contact = SKPhysicsContact()


let arrayOfOptionalInts: [Int?] = [nil, 2, 3, nil, 5]
// Match only non-nil values
for case let number? in arrayOfOptionalInts {
    print("Found a \(number)")
}
// Found a 2
// Found a 3
// Found a 5






//
//func add(x: Int, y: Int) {
//    return x + y
//}

func add2(x: Int) -> Int->Int {
    return { y in x + y }
}


add2(2)
let addfunc = add2(2)
addfunc(9)

func take(x: Int) -> Int -> Int {
    return { y in x + y }
}




let arr = [1,2,3]

arr.map{  $0 + 1 }












