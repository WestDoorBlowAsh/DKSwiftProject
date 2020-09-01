//
//  uselsee.swift
//  DKSwift
//
//  Created by 邓凯 on 2020/3/25.
//  Copyright © 2020 邓凯. All rights reserved.
//

import Foundation
import HandyJSON

class CABaseViewController: DKBaseViewController {}
class BangDingView: UIView {}
class XiuGaiView: UIView {}
class GoldBuZu: UIView {}

//class BangDingView: UIView {}
//class BangDingView: UIView {}

protocol BaseP {
    func pMeth()
}

class confirmP: BaseP {
    func pMeth() {
        
    }
}

class BaseC<Type> where Type: BaseP {
    func cMeth() -> Type {
        let a = confirmP()
        return a as! Type
    }
}

//extension BaseC: BaseP {
//
//
//}

func test() {
    let dic: [String: BaseC<confirmP>] = [:]
}
