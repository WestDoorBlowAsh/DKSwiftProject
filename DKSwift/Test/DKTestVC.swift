//
//  DKTestVC.swift
//  DKSwift
//
//  Created by 邓凯 on 2019/8/29.
//  Copyright © 2019 邓凯. All rights reserved.
//

import UIKit

class DKTestVC: DKBaseViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var nameHintLb: UILabel!
    @IBOutlet weak var pwdTF: UITextField!

    @IBOutlet weak var confirmBtn: UIButton!
    
    @IBOutlet weak var pwdHintLb: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nameValid = nameTF.rx.text.orEmpty
            .map { $0.count >= 2 }
            .share(replay: 1, scope: .whileConnected)
        
        let pwdValid = pwdTF.rx.text.orEmpty
            .map { $0.count >= 6 }
            .share(replay: 1, scope: .whileConnected)
        
        let allValid = Observable.combineLatest(
            nameValid,
            pwdValid
            ) { $0 && $1 }
            .share(replay: 1, scope: .whileConnected)
        
        
        nameValid.bind(to: pwdTF.rx.isEnabled, nameHintLb.rx.isHidden)
            .disposed(by: disposeBag)
    
        
        pwdValid.bind(to: pwdHintLb.rx.isHidden)
            .disposed(by: disposeBag)
        
//        allValid.bind(to: confirmBtn.rx.isEnabled)
//            .disposed(by: disposeBag)
        
        confirmBtn.rx.tap
            .subscribe(onNext: { [unowned self] in
//                self?.showAlert(title: "alert", message: "message")
                
                print("\(DKConst.baseURL)")
                
                ApiProvider.rx.request(.launchAds).subscribe({ (event) in
                    switch event {
                    case let .success(response):
                        
                        let data = response.data
                        let statusCode = response.statusCode
                        
                        let dataString = String.init(data: data, encoding: String.Encoding.utf8)
                        
                        print("get response: \(data) \(statusCode) \(dataString)")
 
                    case let .error(error):
                        print("\(error)")
                    }
                }).disposed(by: self.disposeBag)
                
                
                
                
            })
            .disposed(by: disposeBag)
    }
    

    
}
