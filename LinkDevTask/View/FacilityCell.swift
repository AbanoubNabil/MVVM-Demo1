//
//  FacilityCell.swift
//  LinkDevTask
//
//  Created by Sayed Abdo on 5/31/18.
//  Copyright © 2018 Bombo. All rights reserved.
//

import UIKit

class FacilityCell : UIView {
    
    @IBOutlet var facilityView: FacilityCell!
    @IBOutlet weak var facilityDisc: UILabel!
    @IBOutlet weak var facilityName: UILabel!
    @IBOutlet weak var facilityImage: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    private func commonInit() {
        setupNip()
    }
}
extension FacilityCell{
    
    func setupCell() {
        facilityView.layer.cornerRadius=8
        facilityView.layer.masksToBounds=false
        facilityView.layer.shadowOffset=CGSize(width: 0, height: 4)
        facilityView.layer.shadowOpacity=0.5
    }
    
    func setupNip(){
        Bundle.main.loadNibNamed("FacilityCell", owner: self, options: nil)
        addSubview(facilityView)
        facilityView.frame = self.bounds
        facilityView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            self.roundCorners([.topLeft, .topRight], radius: 8)
    }
    
}
