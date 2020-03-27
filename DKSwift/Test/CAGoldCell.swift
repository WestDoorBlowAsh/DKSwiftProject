//
//  CAGoldCell.swift
//  DKSwift
//
//  Created by 邓凯 on 2020/3/16.
//  Copyright © 2020 邓凯. All rights reserved.
//

import UIKit

class CAGoldCell: UICollectionViewCell {
    
    let backImg = UIImageView().then {
        $0.image = UIImage(named: "p.png")
    }
    
    let titleLb = UILabel().then {
        $0.text = "sss"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 18)
    }
    
    let contentLb = UILabel().then {
        $0.text = "rrrr"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(backImg)
        backImg.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.contentView.addSubview(contentLb)
        contentLb.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(3/2.0)
            $0.centerX.equalToSuperview()
        }
        
        self.contentView.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(1/2.0)
            $0.left.equalTo(contentLb)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
