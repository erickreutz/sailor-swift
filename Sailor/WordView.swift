//
//  WordView.swift
//  Sailor
//
//  Created by Eric on 9/19/14.
//  Copyright (c) 2014 erickreutz. All rights reserved.
//

import UIKit

class WordView: UIView {
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRectZero)
        label.textColor = UIColor.blackColor()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(label)
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.layer.cornerRadius = 10
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        self.addConstraints([
            self.label.al_centerX == self.al_centerX,
            self.label.al_centerY == self.al_centerY
        ])
    }
}
