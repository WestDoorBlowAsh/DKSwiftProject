//
//  DKBaseViewController.swift
//  DKSwift
//
//  Created by 邓凯 on 2019/8/29.
//  Copyright © 2019 邓凯. All rights reserved.
//

import UIKit

class DKBaseViewController: UIViewController {
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupRandowColor(vc: self)
        
        setupViews()
        loadData()
    }
    
    func setupViews() { }
    
    func loadData() { }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DKBaseViewController: DKVCRandomColor {}

