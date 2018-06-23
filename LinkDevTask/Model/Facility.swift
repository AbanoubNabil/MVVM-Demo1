//
//  Photo.swift
//  MojazTask
//
//  Created by Sayed Abdo on 5/27/18.
//  Copyright © 2018 Bombo. All rights reserved.
//

import UIKit

class Facility : NSObject {
    
    var facilityTitle : String = ""
    var facilityBrief : String = ""
    var facilityPrereq : String = ""
    var facilityReqDoc : String = ""
    var facilityFees : String = ""
    var facilityTime : String = ""
    var facilitySChannel : String = ""
    var facilityImgUrl : String = ""
    var facilityPolicies : String = ""
    
    override init() {
    }
    
    init(dictionary: [String:Any])
    {
        facilityFees = dictionary["Fees"] as! String
        facilityTime = dictionary["TimeFrame"] as! String
        facilityBrief = dictionary["Brief"] as! String
        facilityImgUrl = dictionary["MobileImageSrc"] as! String
        facilityTitle = dictionary["Title"] as! String
        facilityPrereq = dictionary["Prerequisites"] as! String
        facilityReqDoc = dictionary["RequiredDocuments"] as! String
        facilitySChannel = dictionary["ServiceChannels"] as! String
        facilityPolicies = dictionary["PoliciesAndProcedures"] as! String
    }
    public class func modelsFromArray(array:[[String:Any]]) -> [Facility]
    {
        var models:[Facility] = []
        for item in array
        {
            models.append(Facility.init(dictionary:item))
        }
        return models
    }
}
