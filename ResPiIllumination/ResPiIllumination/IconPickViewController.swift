//
//  IconPickViewController.swift
//  ResPiIllumination
//
//  Created by JohnBryant on 6/12/16.
//  Copyright © 2016 JohnBryant. All rights reserved.
//

import Foundation
import UIKit

protocol IconPickerViewControllerDelegate: class {
    func iconPicker(picker: IconPickViewController, didPickIcon iconName: String)
}

class IconPickViewController: UITableViewController {
    
    weak var delegate: IconPickerViewControllerDelegate?
    
    let icons = ["whiteBulb", "blueBulb", "greenBulb", "redBulb", "orangeBulb"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设备图标"
        self.navigationController?.navigationBar.configureFlatNavigationBarWithColor(UIColor.midnightBlueColor())
        let attrs = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = attrs
        self.tableView.tableFooterView = UIView()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("iconPickerCell", forIndexPath: indexPath)
        let iconName = icons[indexPath.row]
        cell.textLabel?.text = iconName
        cell.imageView?.image = UIImage(named: iconName)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if let delegate = delegate {
            let iconName = icons[indexPath.row]
            delegate.iconPicker(self, didPickIcon: iconName)
        }
    }
}
