//
//  DKAppDelegateExt.swift
//  DKSwift
//
//  Created by 邓凯 on 2019/8/29.
//  Copyright © 2019 邓凯. All rights reserved.
//

import IQKeyboardManagerSwift

extension DKAppDelegate {
    
    func setupLib(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        setupTabBarController()
        setupIQKeyboardManager()
        
    }
    
    func setupTabBarController() {
        let tabVC = UITabBarController()
        let vcs = [DKUIViewController(), DKTestVC()]
        
        vcs.forEach { (vc) in
            let img = UIImage(named: "pkq")?.withRenderingMode(.alwaysOriginal)
            vc.tabBarItem = UITabBarItem(title: "tab", image: img, selectedImage: img).then {
                $0.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.random], for: .selected)
                $0.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
            }
            let navVC = UINavigationController(rootViewController: vc)
            navVC.navigationBar.isTranslucent = false
            tabVC.addChild(navVC)
        }
        
        window = UIWindow(frame: UIScreen.main.bounds).then {
            $0.backgroundColor = UIColor.white
            $0.makeKeyAndVisible()
            $0.rootViewController = tabVC
        }
    }
    
    func setupIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
}
