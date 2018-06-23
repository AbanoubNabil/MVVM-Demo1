//
//  ImageViewMode.swift
//  MojazTask
//
//  Created by Sayed Abdo on 5/28/18.
//  Copyright © 2018 Bombo. All rights reserved.
//

import UIKit
import SwiftyJSON

class FacilityViewModel : NSObject {
    
    var networkObj = NetworkServiceLayer()
    static var  shared = FacilityViewModel()
    open var updateDelegate : UpdateFacilityListDelegate?
    open var facilities : [Facility] = [Facility]()
    open var selectedFacility : Facility?
    
    override private init() {
        
    }
    
    lazy var handlerBlock: (JSON) -> Void = { items in
        let facilityArray = items["Data"].arrayObject
        print(facilityArray)
        
        if self.facilities.count == 0 {
            self.facilities = Facility.modelsFromArray(array: facilityArray as! [[String : Any]])
            self.updateDelegate?.updateList()
        }else{
            self.facilities.append(contentsOf: Facility.modelsFromArray(array: facilityArray as! [[String : Any]]) )
            self.updateDelegate?.updateList()
        }
        
    }
    
    func getDataFromAPI(indx: Int){
        if indx == 0 && facilities.count == 0{
            facilities.removeAll()
            self.updateDelegate?.updateList()
        }
        if indx == 0 && facilities.count != 0{
                facilities.removeSubrange(0..<facilities.count - 3)
            self.updateDelegate?.updateList()
           
        }
        
        networkObj.fetchRequest(completion: handlerBlock, myurl: "https://dhcr.gov.ae/MobileWebAPI/api/Common/ServiceCatalogue/GetDepartmentServices",indx: indx)
    }
   
}
