//
//  AppDelegate.swift
//  Tan3DTouch
//
//  Created by Tan on 16/6/4.
//  Copyright © 2016年 Tangent. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //  Window
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.rootViewController = UINavigationController(rootViewController: ViewController())
        self.window!.makeKeyAndVisible()
        //  Setup ShortcutItems
        if let shortcutItems = application.shortcutItems where shortcutItems.isEmpty {
            self.setupShortcutItemsWithApplication(application)
        }
        //  Handle ShortcutItems
        var performActionForShortcutItemWhenLaunch = false
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            performActionForShortcutItemWhenLaunch = true
            self.handleShortcutItem(shortcutItem)
        }
    
        return !performActionForShortcutItemWhenLaunch
    }
    
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        let succeed = self.handleShortcutItem(shortcutItem)
        completionHandler(succeed)
    }
}

//  MARK: - ShortcutItem
extension AppDelegate {
    
    enum ShortcutItemsType: String {
        case Share
        case Search
        case Play
        case Pause
    }
    
    func setupShortcutItemsWithApplication(application: UIApplication) {
        let playItem = UIApplicationShortcutItem(type: ShortcutItemsType.Play.rawValue, localizedTitle: "播放", localizedSubtitle: "点击可进行播放", icon: UIApplicationShortcutIcon(type: .Play), userInfo: nil)
        let pauseItem = UIApplicationShortcutItem(type: ShortcutItemsType.Pause.rawValue, localizedTitle: "暂停", localizedSubtitle: "点击可进行暂停", icon: UIApplicationShortcutIcon(type: .Pause), userInfo: nil)
        application.shortcutItems = [playItem, pauseItem]
    }
    
    func handleShortcutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        var succeed = false
        switch shortcutItem.type {
        case ShortcutItemsType.Search.rawValue:
            succeed = true
            print("搜索")
        case ShortcutItemsType.Share.rawValue:
            succeed = true
            print("分享")
        case ShortcutItemsType.Play.rawValue:
            succeed = true
            print("播放")
        case ShortcutItemsType.Pause.rawValue:
            succeed = true
            print("暂停")
        default:
            succeed = false
            print("")
        }
        return succeed
    }
    
}

