//
//  DKUIViewController.swift
//  DKSwift
//
//  Created by 邓凯 on 2020/6/8.
//  Copyright © 2020 邓凯. All rights reserved.
//

import UIKit

class DKUIViewController: DKBaseViewController {
    let tool = DKOCTool.manager();

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let _ = UIButton(type: .system).then {
            $0.setTitle("点我", for: .normal)
            $0.frame = CGRect(x: 100, y: 300, width: 100, height: 100);
            $0.layer.borderColor = UIColor.brown.cgColor
            $0.layer.borderWidth = 1;
            $0.addTarget(self, action: #selector(onButton), for: .touchUpInside)
            view.addSubview($0);
        }
        
    }
    
    @objc func onButton() {
        
        tool.testSemaphore();
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
