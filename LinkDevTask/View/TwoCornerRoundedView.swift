//
//  roundedView.swift
//  LinkDevTask
//
//  Created by Sayed Abdo on 6/1/18.
//  Copyright © 2018 Bombo. All rights reserved.
//

import UIKit

class TwoCornerRoundedView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundCorners([.topLeft, .topRight], radius: 8)
    }

}
