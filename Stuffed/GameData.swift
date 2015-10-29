//
//  GameData.swift
//  Stuffed
//
//  Created by Mac Bellingrath on 10/29/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit


let serviceType = "stuffed"



class GameData: NSObject, NSCoding {

    enum GameAction: String {
        case Move, Fire, Jump
    }
    
    var action: GameAction?
    var direction: PlayerDirection?
    
    required init?(coder aDecoder: NSCoder) {
        
        if let gameaction = aDecoder.decodeObjectForKey("action") as? String, let gamedirection = aDecoder.decodeObjectForKey("direction") as?  String {
            
                action = GameAction(rawValue: gameaction)
                direction = PlayerDirection(rawValue: gamedirection)
        }
        
        
    }
    
    init(action: GameAction, direction: PlayerDirection? = nil) {
        self.action = action
        self.direction = direction
        
        
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        
        aCoder.encodeObject(action?.rawValue, forKey: "action")
        aCoder.encodeObject(direction?.rawValue, forKey: "direction")
        
        
    }
    

    class func data(data: NSData) -> GameData? {
       
        return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? GameData
    }
    
    
    var data: NSData {
    
        return NSKeyedArchiver.archivedDataWithRootObject(self)
    }
    
    
//    func sendInfo(info: [String: String]) {
//        
//        if  let data = try? NSJSONSerialization.dataWithJSONObject(info, options: .PrettyPrinted) {
//            if let bid = boardID {
//                do {
//                    try session.sendData(data, toPeers: [bid], withMode: .Reliable)
//                } catch {
//                    print(error)
//                }
//            }
//        }
//    }

    
//    print(data)
//    
//    if let info = try? NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String: String] {
//        
//        if let action = info?["action"] where action == "move", let direction = info?["direction"] {
//            
//            
//            scene?.movePixel(peerID.displayName, direction: direction )
//        }
//        if let action = info?["action"] where action == "jump" {
//            scene?.jumpPixel(peerID.displayName)
//        }
//        
//        if let action = info?["action"] where action == "fire" {
//            scene?.firePixel(peerID.displayName)
//        }
//        
//    }
//
    
}

