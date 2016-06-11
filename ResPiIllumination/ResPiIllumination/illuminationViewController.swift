//
//  illuminationViewController.swift
//  ResPiIllumination
//
//  Created by JohnBryant on 6/12/16.
//  Copyright © 2016 JohnBryant. All rights reserved.
//

import UIKit

class illuminationViewController: UITableViewController {
    
    var deviceCount = 2
    
    
    @IBOutlet weak var barButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceCount * 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("device", forIndexPath: indexPath)
            
            cell.configureFlatCellWithColor(UIColor.cloudsColor(), selectedColor: UIColor.whiteColor())
            cell.cornerRadius = 5.0
            cell.separatorHeight = 0
            
            let icon = cell.viewWithTag(10001) as! UIImageView
            let nameLabel = cell.viewWithTag(10002) as! UILabel
            let switchBtn = cell.viewWithTag(10003) as! FUISwitch
            switchBtn.on = false
            switchBtn.onColor = UIColor.turquoiseColor()
            switchBtn.offColor = UIColor.clearColor()
            switchBtn.onBackgroundColor = UIColor.midnightBlueColor()
            switchBtn.offBackgroundColor = UIColor.silverColor()
            switchBtn.offLabel.font = UIFont.boldFlatFontOfSize(14)
            switchBtn.onLabel.font = UIFont.boldFlatFontOfSize(14)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("luminance", forIndexPath: indexPath)
            cell.configureFlatCellWithColor(UIColor.cloudsColor(), selectedColor: UIColor.cloudsColor())
            cell.cornerRadius = 5.0
            cell.separatorHeight = 8.0
            
            let slider = cell.viewWithTag(10004) as! UISlider
            
            slider.configureFlatSliderWithTrackColor(UIColor.silverColor(), progressColor: UIColor.alizarinColor(), thumbColor: UIColor.pomegranateColor())
            
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.row % 2 == 0 {
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("illuminationDetail")
            self.navigationController?.pushViewController(vc, animated: true)
        }

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
    
    func configUI() {
        self.tableView.tableFooterView = UIView()
        self.navigationController?.navigationBar.configureFlatNavigationBarWithColor(UIColor.midnightBlueColor())
        let attrs = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = attrs
        barButton.configureFlatButtonWithColor(UIColor.peterRiverColor(), highlightedColor: UIColor.belizeHoleColor(), cornerRadius: 3)
    }
    
}
