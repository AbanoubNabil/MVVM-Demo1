//
//  FacilitiesVCTableViewController.swift
//  LinkDevTask
//
//  Created by Sayed Abdo on 5/31/18.
//  Copyright © 2018 Bombo. All rights reserved.
//

import UIKit
import Foundation
import SDWebImage

class FacilitiesVC: UITableViewController, UpdateFacilityListDelegate {

    var indexCount = 1
    var viewModel = FacilityViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel.networkObj.isConnectedToInternet() {
            viewModel.getDataFromAPI(indx: 0)
        }else{
            showNetworkAlert()
        }
        
        viewModel.updateDelegate = self
        setupNavigationController()
        tableView.estimatedRowHeight = 180
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 220
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func updateList() {
        tableView.reloadData()
    }
    
    func setupNavigationController() {
        let backImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.title = " Our Facilities"
    }

}


// MARK: - Table view data source
extension FacilitiesVC{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.facilities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        if indexPath.row <= viewModel.facilities.count {
            setFacilityAttributes(cell: cell, facility: viewModel.facilities[indexPath.row])
        }
        
        if indexPath.row == viewModel.facilities.count - 1 {
            if indexCount <= 2 {
                viewModel.getDataFromAPI(indx: indexCount)
                indexCount += 1
            }else{
                indexCount = 0
                viewModel.getDataFromAPI(indx: indexCount)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "facilityDetailVC") as? FacilityDetailsVC {
            if let navigator = navigationController {
                viewModel.selectedFacility = viewModel.facilities[indexPath.row]
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func setFacilityAttributes(cell: UITableViewCell, facility : Facility) {
        let facilitytitle = cell.viewWithTag(2) as! UILabel
        facilitytitle.text = facility.facilityTitle
        let facilityBrief = cell.viewWithTag(3) as! UILabel
        facilityBrief.text = facility.facilityBrief
        let facilityImage = cell.viewWithTag(1) as! UIImageView
        print(facility.facilityImgUrl)
        facilityImage.imgroundCorners([.topLeft ,.topRight], radius: 10)
        facilityImage.sd_setImage(with: URL(string: facility.facilityImgUrl), completed : nil)
    }
    
    func showNetworkAlert()  {
        let alert = UIAlertController(title: "No internet connection", message: "please open internet to load data ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{ action in
            
            if let url = URL(string:"App-Prefs:root=Network&path=Location") {
                if UIApplication.shared.canOpenURL(url) {
                    _ =  UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler:{ action in
             UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
            // terminaing app in background
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                exit(EXIT_SUCCESS)
            })
        }))
        self.present(alert, animated: true)
    }
    
}
