//
//  IlluminationDetailViewController.swift
//  ResPiIllumination
//
//  Created by JohnBryant on 6/12/16.
//  Copyright © 2016 JohnBryant. All rights reserved.
//

import UIKit
import Foundation

protocol IlluminationDetailViewControllerDelegate: class {
    func editDeviceInfo(controller: IlluminationDetailViewController, device: Device)
}


class IlluminationDetailViewController: UITableViewController, IconPickerViewControllerDelegate {
    
    var device: Device!
    weak var delegate: IlluminationDetailViewControllerDelegate?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var information: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 30
        } else {
            return 15
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0 && indexPath.row == 1 {
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("iconPickerView") as! IconPickViewController
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func configUI() {
        self.title = "设备详情"
        self.tableView.tableFooterView = UIView()
        self.navigationController?.navigationBar.configureFlatNavigationBarWithColor(UIColor.midnightBlueColor())
        let attrs = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = attrs
        
        self.navigationController?.navigationItem.rightBarButtonItem?.title = "完成"
        
        nameTextField.text = device.name
        icon.image = UIImage(named: device.iconName)
        information.text = device.information

    }

    
    @IBAction func doneEdit(sender: AnyObject) {
        updateInfo()
        self.delegate?.editDeviceInfo(self, device: self.device)
    }
    
    // 实现代理方法
    func iconPicker(picker: IconPickViewController, didPickIcon iconName: String) {
        self.device.iconName = iconName
        self.icon.image = UIImage(named: device.iconName)
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    func updateInfo() {
        self.device.name = self.nameTextField.text
        self.device.information = self.information.text
    }

    
}
