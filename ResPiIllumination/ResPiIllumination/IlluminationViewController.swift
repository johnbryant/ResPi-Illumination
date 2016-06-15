//
//  IlluminationViewController.swift
//  ResPiIllumination
//
//  Created by JohnBryant on 6/12/16.
//  Copyright © 2016 JohnBryant. All rights reserved.
//

import UIKit
import FlatUIKit
import SocketIOClientSwift

class IlluminationViewController: UITableViewController, NSStreamDelegate,IlluminationDetailViewControllerDelegate{
    
    var deviceCount = 3
    var devices = [Device]()
    
    
    // 网络接口
    let addr = "192.168.1.106"
    let port = 2016
    var inStream: NSInputStream?
    var outStream: NSOutputStream?
    var buffer = [UInt8](count: 200, repeatedValue: 0)
    
    
    @IBOutlet weak var barButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel1: UILabel!
    @IBOutlet weak var nameLabel2: UILabel!
    @IBOutlet weak var nameLabel3: UILabel!
    @IBOutlet weak var icon1: UIImageView!
    @IBOutlet weak var icon2: UIImageView!
    @IBOutlet weak var icon3: UIImageView!
    
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var switch3: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        configUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        netWorkEnable()
    }
    
//        
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        if indexPath.row % 2 == 0 {
//            let cell = tableView.dequeueReusableCellWithIdentifier("device", forIndexPath: indexPath)
//            
//            cell.configureFlatCellWithColor(UIColor.cloudsColor(), selectedColor: UIColor.whiteColor())
//            cell.cornerRadius = 5.0
//            cell.separatorHeight = 0
//            
//            let icon = cell.viewWithTag(10001) as! UIImageView
//            let nameLabel = cell.viewWithTag(10002) as! UILabel
//            let switchBtn = cell.viewWithTag(10003) as! UISwitch
//
//            icon.image = UIImage(named: devices[indexPath.row/2].iconName)
//            nameLabel.text = devices[indexPath.row/2].name
//            
//            switchBtn.on = devices[indexPath.row/2].on
////            let switchBtn = FUISwitch()
////            switchBtn.on = devices[indexPath.row/2].on
////            switchBtn.onColor = UIColor.turquoiseColor()
////            switchBtn.offColor = UIColor.clearColor()
////            switchBtn.onBackgroundColor = UIColor.midnightBlueColor()
////            switchBtn.offBackgroundColor = UIColor.silverColor()
////            switchBtn.offLabel.font = UIFont.boldFlatFontOfSize(14)
////            switchBtn.onLabel.font = UIFont.boldFlatFontOfSize(14)
//            switchBtn.addTarget(self, action: #selector(switchDevice), forControlEvents: .ValueChanged)
//            
//
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCellWithIdentifier("luminance", forIndexPath: indexPath)
//            cell.configureFlatCellWithColor(UIColor.cloudsColor(), selectedColor: UIColor.cloudsColor())
//            cell.cornerRadius = 5.0
//            cell.separatorHeight = 8.0
//            
//            let slider = cell.viewWithTag(10004) as! UISlider
//            slider.minimumValue = 0
//            slider.maximumValue = 100
//            
//            if !devices[(indexPath.row-1)/2].on {
//                slider.value = 0
//            } else {
//                slider.value = 50
//            }
//            
//            slider.configureFlatSliderWithTrackColor(UIColor.silverColor(), progressColor: UIColor.alizarinColor(), thumbColor: UIColor.pomegranateColor())
//            
//            return cell
//        }
//    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0 {
            performSegueWithIdentifier("deviceDetailSegue", sender: devices[0])
        } else if indexPath.section == 1 {
            performSegueWithIdentifier("deviceDetailSegue", sender: devices[1])
        } else if indexPath.section == 2 {
            performSegueWithIdentifier("deviceDetailSegue", sender: devices[2])
        }

    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 80
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "deviceDetailSegue" {
            let vc = segue.destinationViewController as! IlluminationDetailViewController
            vc.delegate = self
            vc.device = sender as! Device
        }
    }
    
    
    // UI风格初始化
    func configUI() {
        self.tableView.tableFooterView = UIView()
        self.navigationController?.navigationBar.configureFlatNavigationBarWithColor(UIColor.midnightBlueColor())
        let attrs = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = attrs
        barButton.configureFlatButtonWithColor(UIColor.peterRiverColor(), highlightedColor: UIColor.belizeHoleColor(), cornerRadius: 3)
        
        let icons = [icon1, icon2, icon3]
        let nameLabels = [nameLabel1, nameLabel2, nameLabel3]
        let switchs = [switch1, switch2, switch3]
        
        for i in 0 ... 2 {
            icons[i].image = UIImage(named: devices[i].iconName)
            nameLabels[i].text = devices[i].name
            switchs[i].on = devices[i].on
        }
        
    }
    
    func initData() {
        let device1 = Device(id: 0, name: "照明设备1", iconName: "whiteBulb", information: "用于卧室照明")
        let device2 = Device(id: 1, name: "照明设备2", iconName: "blueBulb", information: "用于厕所照明")
        let device3 = Device(id: 2, name: "照明设备3", iconName: "orangeBulb", information: "用于厨房的照明")
        devices.append(device1)
        devices.append(device2)
        devices.append(device3)
    }
    
    // 定义代理方法
    func editDeviceInfo(controller: IlluminationDetailViewController, device: Device) {
        let id = device.id
        devices[id] = device
        print("device: \(device.iconName)")
        self.navigationController?.popViewControllerAnimated(true)
        configUI()
    }
    
    // 设备开关按钮
    func switchDevice(sender: FUISwitch) {
        print("hello bitch")
        devices[0].on = sender.on
//        let data: NSData = 
        outStream?.write(UnsafePointer<UInt8>(bitPattern: 19), maxLength: 5)
        self.tableView.reloadData()
    }
    
    // 设置存储路径
    func documentDirectory() -> String {
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return path[0]
    }
    
    func dateFilePath() -> String {
        return (documentDirectory() as NSString).stringByAppendingString("illumination.plist")
    }


    func netWorkEnable() {
        NSStream.getStreamsToHostWithName(addr, port: port, inputStream: &inStream, outputStream: &outStream)
        inStream?.delegate = self
        outStream?.delegate = self
        
        inStream?.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        outStream?.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        
        inStream?.open()
        outStream?.open()
        
        buffer = [UInt8](count: 200, repeatedValue: 0)
    }
    
    func stream(aStream: NSStream, handleEvent eventCode: NSStreamEvent) {
        switch eventCode {
        case NSStreamEvent.EndEncountered:
            print("EndEncountered")
            print("Connection stopped by server")
            inStream?.close()
            inStream?.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
            outStream?.close()
            print("Stop outStream currentRunLoop")
            outStream?.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)

        case NSStreamEvent.ErrorOccurred:
            print("ErrorOccurred")
            
            inStream?.close()
            inStream?.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
            outStream?.close()
            outStream?.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
            print("Failed to connect to server")

        case NSStreamEvent.HasBytesAvailable:
            print("HasBytesAvailable")
            
            if aStream == inStream {
                inStream!.read(&buffer, maxLength: buffer.count)
                let bufferStr = NSString(bytes: &buffer, length: buffer.count, encoding: NSUTF8StringEncoding)
                print(bufferStr!)
            }
            
        case NSStreamEvent.HasSpaceAvailable:
            print("HasSpaceAvailable")
        case NSStreamEvent.None:
            print("None")
        case NSStreamEvent.OpenCompleted:
            print("OpenCompleted")
        default:
            print("Unknown")
        }
    }
    
}
