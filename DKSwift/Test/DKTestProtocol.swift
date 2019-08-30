//
//  DKProtocol.swift
//  DKSwift
//
//  Created by 邓凯 on 2019/8/29.
//  Copyright © 2019 邓凯. All rights reserved.
//

import UIKit

protocol DKVCRandomColor {
    
    func setupRandowColor(vc: UIViewController)
}

// 协议扩展的默认实现
extension DKVCRandomColor {
    
    func setupRandowColor(vc: UIViewController) {
//        vc.view.backgroundColor = .random
    }
    
}
