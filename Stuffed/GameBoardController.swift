//
//  GameBoardController.swift
//  Stuffed
//
//  Created by Mac Bellingrath on 10/27/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit
import MultipeerConnectivity
import SpriteKit

typealias PeerInfo = [DisplayName:[String:String]?]

class GameBoardController: UIViewController, MCNearbyServiceBrowserDelegate, MCSessionDelegate {
    
    
    var waitingPeers: [MCPeerID] = []
    var sendingInvite = false
    
    var session: MCSession!
    var browser: MCNearbyServiceBrowser!
    var myPeerId: MCPeerID = MCPeerID(displayName: "Board")
    let scene = GameBoardScene(fileNamed: "GameBoard")
    
    
    var peerInfo: PeerInfo = [:]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let skView = view as? SKView {
        
          
            if  let scene = scene {
                
                skView.presentScene(scene)
                
            }
        }
      
        
        
        session = MCSession(peer: myPeerId)
        
        browser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: "stuffed")
        browser.delegate = self
        browser.startBrowsingForPeers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //
    
    func sendInvite() {
        if let peerId = waitingPeers.first {
            sendingInvite = true
            waitingPeers.removeFirst()
            browser.invitePeer(peerId, toSession: session, withContext: nil, timeout: 10)
        }
    }
    //MARK: - MCBrowser
    
    func browser(browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        
        
        if session.connectedPeers.contains(peerID) { return }
        
        peerInfo[peerID.displayName] = info
        
        if waitingPeers.contains(peerID) { return }
        waitingPeers.append(peerID)
        
        if !sendingInvite { sendInvite() }
        
        
    }
    
    func browser(browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        
    }
    
    //MARK: - MCSession
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        
        //if file received
    }
    
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        
        //if data
        
        print(data)
        
        if let info = try? NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String: String] {
          
            if let action = info?["action"] where action == "move", let direction = info?["direction"] {
                
                
                scene?.movePixel(peerID.displayName, direction: direction )
            }
            if let action = info?["action"] where action == "jump" {
                scene?.jumpPixel(peerID.displayName)
            }
            
            if let action = info?["action"] where action == "fire" {
                scene?.firePixel(peerID.displayName)
            }
            
        }
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
        if let color = peerInfo[peerID.displayName]??["color"] {
            scene?.addPixel(peerID.displayName, colorName: color)
        } else {
            scene?.addPixel(peerID.displayName)}
        fallthrough
        case .NotConnected:
            print(state.description)
            scene?.removePixel(peerID.displayName)
            browser.startBrowsingForPeers()
            sendingInvite = false
            sendInvite()
            
        }
  
    }
    func session(session: MCSession, didReceiveCertificate certificate: [AnyObject]?, fromPeer peerID: MCPeerID, certificateHandler: (Bool) -> Void) {
        
        certificateHandler(true)
    }
}

extension MCSessionState: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .Connected: return "Connected"
        case .Connecting: return "Connecting"
        case .NotConnected: return "Not Connected"
        }
    
    }
    
}

