//
//  FacilityDetailsVC.swift
//  LinkDevTask
//
//  Created by Sayed Abdo on 5/31/18.
//  Copyright © 2018 Bombo. All rights reserved.
//

import UIKit
import WebKit

class FacilityDetailsVC: UITableViewController,WKNavigationDelegate {
    
    var staticTableCellCounter = 0
    var rowHeight : CGFloat = 0.0
    
    @IBOutlet weak var facilityService: UILabel!
    @IBOutlet weak var facilityTime: UILabel!
    @IBOutlet weak var facilityImg: UIImageView!
    @IBOutlet weak var facilityBrief: UILabel!
    
    
    var viewModel = FacilityViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeOutlets()
        self.title=viewModel.selectedFacility?.facilityTitle
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
   
    
    func initializeOutlets() {
        facilityTime.attributedText = viewModel.selectedFacility?.facilityTime.html2AttributedString
        facilityBrief.attributedText = viewModel.selectedFacility?.facilityBrief.html2AttributedString
        facilityService.attributedText = viewModel.selectedFacility?.facilitySChannel.html2AttributedString
        facilityImg.sd_setImage(with: URL(string: (viewModel.selectedFacility?.facilityImgUrl)!), completed: nil)
    }

}


// MARK: - Table view data source
extension FacilityDetailsVC{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        configureWebViewCell(cell: cell, indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return configureCellHeight(indexPath: indexPath);
    }
    
    
}

// MARK: - WKWbview methods
extension FacilityDetailsVC{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        webView.scrollView.bounces = true
        webView.scrollView.isScrollEnabled = true
        
    }
    func configureWebViewCell(cell : UITableViewCell , indexPath : IndexPath){
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        if indexPath.row == 0 { cell.viewWithTag(9)?.roundCorners([.topLeft,.topRight], radius: 10)
            cell.viewWithTag(10)?.roundCorners([.topLeft,.topRight], radius: 10)
        }
        if staticTableCellCounter < 7 {
            switch indexPath.row {
            case 1:
                let facilityPrereq : WKWebView = cell.viewWithTag(2) as! WKWebView
                facilityPrereq.navigationDelegate = self
                    facilityPrereq.loadHTMLString((viewModel.selectedFacility?.facilityPrereq)!,baseURL:URL(string:"https://dhcr.gov.ae/"))
                    facilityPrereq.frame = CGRect.init(x: 18.0, y: 40.0, width: cell.frame.size.width, height: (self.viewModel.selectedFacility?.facilityPrereq.html2AttributedString?.height(withConstrainedWidth: screenWidth-70))!)
                    
                    facilityPrereq.scrollView.contentSize.height = (self.viewModel.selectedFacility?.facilityPrereq.html2AttributedString?.height(withConstrainedWidth: screenWidth-70))!
                
                
                facilityPrereq.scrollView.bounces = false
                facilityPrereq.scrollView.isScrollEnabled = false
                facilityPrereq.allowsLinkPreview = true
            case 2:
                let facilityReqDoc : WKWebView = cell.viewWithTag(3) as! WKWebView
                facilityReqDoc.navigationDelegate = self
                facilityReqDoc.loadHTMLString((viewModel.selectedFacility?.facilityReqDoc)!,baseURL:URL(string:"https://dhcr.gov.ae/"))
                
                facilityReqDoc.frame = CGRect.init(x: 18.0, y: 40.0, width: cell.frame.size.width, height: (self.viewModel.selectedFacility?.facilityReqDoc.html2AttributedString?.height(withConstrainedWidth: screenWidth-70))!)
                facilityReqDoc.scrollView.contentSize.height = (self.viewModel.selectedFacility?.facilityReqDoc.html2AttributedString?.height(withConstrainedWidth: screenWidth-70))!
                facilityReqDoc.scrollView.bounces = false
                facilityReqDoc.scrollView.isScrollEnabled = false
                facilityReqDoc.allowsLinkPreview = true
            case 3:
                let webView : WKWebView = cell.viewWithTag(4) as! WKWebView
                webView.navigationDelegate = self
                webView.loadHTMLString((viewModel.selectedFacility?.facilityFees)!,baseURL:URL(string:"https://dhcr.gov.ae/"))
                
                webView.frame = CGRect.init(x: 18.0, y: 40.0, width: cell.frame.size.width, height: (self.viewModel.selectedFacility?.facilityFees.html2AttributedString?.height(withConstrainedWidth: screenWidth-70))!)
                webView.scrollView.contentSize.height = (self.viewModel.selectedFacility?.facilityFees.html2AttributedString?.height(withConstrainedWidth: screenWidth-70))!
                webView.scrollView.bounces = false
                webView.scrollView.isScrollEnabled = false
                webView.allowsLinkPreview = true
                webView.allowsBackForwardNavigationGestures = true
            case 6:
                let facilityPolicies : WKWebView = cell.viewWithTag(5) as! WKWebView
                facilityPolicies.navigationDelegate = self
                facilityPolicies.loadHTMLString((viewModel.selectedFacility?.facilityPolicies)!,baseURL:URL(string:"https://dhcr.gov.ae/"))
                facilityPolicies.frame = CGRect.init(x: 18.0, y: 40.0, width: cell.frame.size.width, height: (self.viewModel.selectedFacility?.facilityPolicies.html2AttributedString?.height(withConstrainedWidth: screenWidth-70))!)
                facilityPolicies.scrollView.contentSize.height = (self.viewModel.selectedFacility?.facilityPolicies.html2AttributedString?.height(withConstrainedWidth: screenWidth-70))!
                facilityPolicies.scrollView.bounces = false
                facilityPolicies.scrollView.isScrollEnabled = false
                facilityPolicies.allowsLinkPreview = true
                facilityPolicies.allowsBackForwardNavigationGestures = true
            default:
                staticTableCellCounter += 1
                
            }
        }
    }
    
    func configureCellHeight(indexPath : IndexPath) -> CGFloat {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        switch indexPath.row {
        case 1:
            return (self.viewModel.selectedFacility?.facilityPrereq.html2AttributedString?.height(withConstrainedWidth: screenWidth-70))!
        case 2:
            return (self.viewModel.selectedFacility?.facilityReqDoc.html2AttributedString?.height(withConstrainedWidth: screenWidth-70))!
        case 3:
            return (self.viewModel.selectedFacility?.facilityFees.html2AttributedString?.height(withConstrainedWidth: screenWidth-70))!
        case 6:
            return (self.viewModel.selectedFacility?.facilityPolicies.html2AttributedString?.height(withConstrainedWidth: screenWidth-70))!
        default:
            print("default")
        }
        return UITableViewAutomaticDimension
    }
}
