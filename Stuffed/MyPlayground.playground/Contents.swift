
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





//switch point {
//case ("0", "0"):
//    print("(0, 0) is at the origin.")
//default:
//    print("The point is at (\(point.0), \(point.1)).")
//}
//// prints "The point is at (1, 2).