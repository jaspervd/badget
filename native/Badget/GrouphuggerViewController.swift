//
//  TableViewController.swift
//  BluetoothTest
//
//  Created by Jasper Van Damme on 31/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import Alamofire
import CoreBluetooth

class GrouphuggerViewController: UIViewController, ChallengeProtocol, UITableViewDelegate, CBCentralManagerDelegate, UITableViewDataSource {
    var centralManager:CBCentralManager!
    var peripheralsArray:Array<CBPeripheral> = []
    var connectedFriends:Array<CBPeripheral> = []
    var detailView:GrouphuggerDetailView!
    var visualView:GrouphuggerVisualView!
    var scoreView:GrouphuggerScoreView!
    var started:Bool = false
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = UIView(frame: bounds)
        self.detailView = GrouphuggerDetailView(frame: bounds)
        self.visualView = GrouphuggerVisualView(frame: bounds)
        self.scoreView = GrouphuggerScoreView(frame: bounds)
    }

    override func viewDidLoad() {
        self.centralManager = CBCentralManager(delegate: nil, queue: nil)
        self.centralManager.delegate = self
        super.viewDidLoad()
        
        self.view.addSubview(self.detailView)
        self.visualView.delegate = self
        self.visualView.dataSource = self
        
        self.visualView.registerClass(PeripheralCell.classForCoder(), forCellReuseIdentifier: "peripheralCell")
        self.detailView.btnContinue.addTarget(self, action: "didStartChallenge", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func didStartChallenge() {
        UIView.transitionFromView(self.detailView, toView: self.visualView, duration: 1, options: UIViewAnimationOptions.CurveEaseInOut, completion: nil)
        self.started = true
        if(self.centralManager.state == .PoweredOn) {
            self.centralManager.scanForPeripheralsWithServices(nil, options: nil)
        }
    }
    
    func didFinishChallenge() {
        UIView.transitionFromView(self.visualView, toView: self.scoreView, duration: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, completion: nil)
        self.started = false
        self.scoreView.friendsText.text = "Je had \(self.connectedFriends.count) vrienden bij je!"
        var grouphugger = Grouphugger(friends: self.connectedFriends.count)
        NSUserDefaults.standardUserDefaults().setObject(Settings.currentDate, forKey: "grouphuggerDate")
        let parameters = [
            "user_id": NSUserDefaults.standardUserDefaults().integerForKey("userId"),
            "day": Settings.currentDate,
            "friends": grouphugger.friends
        ]
        Alamofire.request(.POST, Settings.apiUrl + "/grouphugger", parameters: parameters)
    }
    
    func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
        var arr = self.peripheralsArray.filter( { return $0.identifier == peripheral.identifier } )
        if(arr.count == 0) {
            self.peripheralsArray.append(peripheral)
            self.visualView.reloadData()
        }
    }
    
    func centralManager(central: CBCentralManager!, didConnectPeripheral peripheral: CBPeripheral!) {
        self.connectedFriends.append(peripheral)
        self.visualView.reloadData()
    }
    
    func centralManager(central: CBCentralManager!, didDisconnectPeripheral peripheral: CBPeripheral!, error: NSError!) {
        self.peripheralsArray.removeAtIndex(find(self.peripheralsArray, peripheral)!)
        self.connectedFriends.removeAtIndex(find(self.connectedFriends, peripheral)!)
        self.visualView.reloadData()
    }
    
    func centralManager(central: CBCentralManager!, didFailToConnectPeripheral peripheral: CBPeripheral!, error: NSError!) {
        println("didFailToConnect")
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager!) {
        switch(central.state) {
        case .Unsupported:
            println("Unsupported")
        case .Unauthorized:
            println("Unauthorized")
        case .Unknown:
            println("Unknown")
        case .Resetting:
            println("Resetting")
        case .PoweredOff:
            println("PoweredOff")
            let alertController = UIAlertController(title: "Bluetooth staat uit", message:
                "Om te kunnen verbinden met je vrienden moet je bluetooth aan staan.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Oké", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        case .PoweredOn:
            println("PoweredOn")
            central.scanForPeripheralsWithServices(nil, options: nil)
        default:
            println("Default")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.peripheralsArray.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("peripheralCell", forIndexPath: indexPath) as! UITableViewCell
        
        var peripheral = self.peripheralsArray[indexPath.row]
        cell.textLabel?.text = peripheral.name
        
        var state = "Unknown"
        switch(peripheral.state) {
        case .Disconnected:
            state = "Disconnected"
        case .Connecting:
            state = "Connecting"
        case .Connected:
            state = "Connected"
        }
        
        cell.detailTextLabel?.text = state

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var peripheral = self.peripheralsArray[indexPath.row]
        
        self.centralManager.connectPeripheral(peripheral, options: nil)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
