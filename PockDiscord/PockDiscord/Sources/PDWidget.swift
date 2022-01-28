//
//  PDWidget.swift
//  PockDiscord
//
//  Created by Dominic Lacaille on 2022-01-28.
//  
//

import Foundation
import AppKit
import PockKit

class PDWidget: PKWidget {
    
    static var identifier: String = "dlacaille.PockDiscord"
    var customizationLabel: String = "PockDiscord"
    var view: NSView!
    
    required init() {
        self.view = PKButton(title: "🎤", target: self, action: #selector(muteDiscord))
    }
    
    private func findDiscordPid() -> pid_t {
        let workspace = NSWorkspace.shared
        let applications = workspace.runningApplications
        for app in applications {
            if (app.bundleIdentifier == "com.hnc.Discord") {
                return app.processIdentifier
            }
        }
        return 0
    }
    
    @objc private func muteDiscord() {
        let src = CGEventSource(stateID: CGEventSourceStateID.hidSystemState)
        
        let cmdd = CGEvent(keyboardEventSource: src, virtualKey: 0x37, keyDown: true)
        let cmdu = CGEvent(keyboardEventSource: src, virtualKey: 0x37, keyDown: false)
        
        let shiftd = CGEvent(keyboardEventSource: src, virtualKey: 0x38, keyDown: true)
        let shiftu = CGEvent(keyboardEventSource: src, virtualKey: 0x38, keyDown: false)
        
        let md = CGEvent(keyboardEventSource: src, virtualKey: 0x2E, keyDown: true)
        let mu = CGEvent(keyboardEventSource: src, virtualKey: 0x2E, keyDown: false)
        
        let mask = CGEventFlags.maskCommand.rawValue | CGEventFlags.maskShift.rawValue;
        md?.flags = CGEventFlags(rawValue: mask);

        let pid = findDiscordPid();
            
        cmdd?.postToPid(pid)
        shiftd?.postToPid(pid)
        md?.postToPid(pid)
        mu?.postToPid(pid)
        shiftu?.postToPid(pid)
        cmdu?.postToPid(pid)
    }
    
}
