//
//  illuminationViewController.swift
//  ResPiIllumination
//
//  Created by JohnBryant on 6/12/16.
//  Copyright © 2016 JohnBryant. All rights reserved.
//

import UIKit

class illuminationViewController: UITableViewController {
    
    var deviceCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceCount * 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("device", forIndexPath: indexPath)
            let icon = cell.viewWithTag(10001) as! UIImageView
            let nameLabel = cell.viewWithTag(10002) as! UILabel
            let switchBtn = cell.viewWithTag(10003) as! UISwitch
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("luminance", forIndexPath: indexPath)
            let slider = cell.viewWithTag(10004) as! UISlider
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("illuminationDetail")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
            return 80
        } else {
            return 44
        }
    }
    
    func configSwitchSlider() {
        
    }
    
}
