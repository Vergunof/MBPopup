//
//  AppDelegate.swift
//  Example
//
//  Created by Mahdi Bchetnia on 16/8/25.
//  Copyright © 2016 Mahdi Bchetnia. See LICENSE.
//

import Cocoa
import MBPopup

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let popupController: MBPopupController
    let myView = NSView(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
    let label = NSTextField(frame: CGRect(x: 50, y: 175, width: 200, height: 50))
    let secondStatusItem = NSStatusBar.system().statusItem(withLength: 30)

    override init() {
        self.popupController = MBPopupController(contentView: myView)
        super.init()
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        MBPopup.openDuration = 0.15 // Default value
        MBPopup.closeDuration = 0.2 // Default value
        MBPopup.arrowSize = CGSize(width: 12, height: 8) // Default value

        secondStatusItem.title = "test"
        secondStatusItem.menu = NSMenu()
        secondStatusItem.menu?.addItem(withTitle: "Normal status item is unaffected", action: nil, keyEquivalent: "")

        popupController.statusItem.title = "Popup"
        popupController.statusItem.length = 48
        popupController.backgroundView.backgroundColor = NSColor.windowBackgroundColor

        popupController.willOpenPopup = { keys in
            var labelText = "Hi!"

            switch keys {
            case .option:
                debugPrint("Will open popup with option pressed!")
                labelText = "Hi, option user ;)"
            case .shift:
                debugPrint("Will open popup with shift pressed!")
            case .shiftOption:
                debugPrint("Will open popup with shift+option pressed!")
            case .none:
                debugPrint("Will open popup!")
            }

            self.label.stringValue = labelText
        }

        popupController.didOpenPopup = { debugPrint("Opened popup!") }
        popupController.willClosePopup = { debugPrint("Will close popup!") }
        popupController.didClosePopup = { debugPrint("Closed popup!") }

        label.font = NSFont.systemFont(ofSize: 24)
        label.isBezeled = false
        label.drawsBackground = false
        label.isEditable = false
        label.isSelectable = false
        label.alignment = NSTextAlignment.center
        myView.addSubview(label)
    }

    func applicationWillTerminate(_ aNotification: Notification) {}
}

