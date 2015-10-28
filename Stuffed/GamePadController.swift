//
//  GamePadController.swift
//  Stuffed
//
//  Created by Mac Bellingrath on 10/27/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//


import UIKit
import MultipeerConnectivity

let colors = [
    "red" : UIColor.redColor(),
    "blue" : UIColor.blueColor(),
    "cyan" : UIColor.cyanColor(),
    "green" : UIColor.greenColor(),
    "yellow" : UIColor.yellowColor(),
    "purple" : UIColor.purpleColor(),
    "magenta" : UIColor.magentaColor(),
    "black" : UIColor.blackColor(),
    "white" : UIColor.whiteColor(),
    "orange" : UIColor.orangeColor(),
    
    
]

class GamePadController: UIViewController, MCNearbyServiceAdvertiserDelegate, MCSessionDelegate {

    var session: MCSession!
    var advertiser: MCNearbyServiceAdvertiser!
    var myPeerId = MCPeerID(displayName: UIDevice.currentDevice().name)
    var boardID: MCPeerID?

    
    
 
    
    @IBAction func gamePadControllerButtonPressed(sender: UIButton) {
        
        
        if let titlelabel = sender.titleLabel, let text = titlelabel.text {
            
            
        
        switch text {
            
        case "Jump": sendInfo([ "action" : "Jump"])
        case "Fire": sendInfo([ "action" : "Fire"])
        case "Left": sendInfo([ "action" : "move", "direction": "left" ])
        case "Right": sendInfo([ "action" : "move", "direction": "right" ])
        

        default: break
            }
        }
    }

    
    
    
    func sendInfo(info: [String: String]) {
        
        if  let data = try? NSJSONSerialization.dataWithJSONObject(info, options: .PrettyPrinted) {
            if let bid = boardID {
                do {
                    try session.sendData(data, toPeers: [bid], withMode: .Reliable)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        session = MCSession(peer: myPeerId)
        advertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: "stuffed")
        advertiser.delegate = self
        advertiser.startAdvertisingPeer()
        
        
    }

    

    //MARK: - MCSession
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        
        //if file received
    }
    
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        //if data
    }
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        // streaming data
        
    }
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
        
        //resource
        
    }
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        //state change
        
        switch state {
            
        case .Connecting: print(state.description)
        case .Connected: print(state.description)
        case .NotConnected: print(state.description)
            
        }
        
        
        
        
    }

    
    
    
    
    
    //MARK: MCNearbyServicesAdvertiser
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: NSData?, invitationHandler: (Bool, MCSession) -> Void) {
        
        guard peerID.displayName == "Board" else { invitationHandler(false, session); return }
            
        invitationHandler(true, session)
        self.boardID = peerID
//        advertiser.stopAdvertisingPeer()
        
    }
  
   
}



















