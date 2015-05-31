//
//  TableViewController.swift
//  BluetoothTest
//
//  Created by Jasper Van Damme on 31/05/15.
//  Copyright (c) 2015 Jasper Van Damme. All rights reserved.
//

import UIKit
import CoreBluetooth

class GrouphuggerViewController: UIViewController, UITableViewDelegate, CBCentralManagerDelegate {
    let centralManager = CBCentralManager(delegate: nil, queue: nil)
    var peripheralsArray:Array<CBPeripheral> = []
    let detailView = UITableView()
    
    var grouphuggerView:GrouphuggerView! {
        get {
            return self.view as! GrouphuggerView
        }
    }
    
    override func loadView() {
        var bounds = UIScreen.mainScreen().bounds
        self.view = GrouphuggerView(frame: bounds)
        self.detailView.frame = bounds
    }

    override func viewDidLoad() {
        self.centralManager.delegate = self
        super.viewDidLoad()
        
        self.view.addSubview(self.detailView)
        self.detailView.delegate = self
        
        self.detailView.registerClass(PeripheralCell.classForCoder(), forCellReuseIdentifier: "peripheralCell")
        self.grouphuggerView.btnContinue.addTarget(self, action: "startChallenge", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func startChallenge() {
        self.view = self.detailView
    }
    
    func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
        var arr = peripheralsArray.filter( { return $0.identifier == peripheral.identifier } )
        if(arr.count == 0) {
            self.peripheralsArray.append(peripheral)
            self.detailView.reloadData()
        }
    }
    
    func centralManager(central: CBCentralManager!, didConnectPeripheral peripheral: CBPeripheral!) {
        self.detailView.reloadData()
    }
    
    func centralManager(central: CBCentralManager!, didDisconnectPeripheral peripheral: CBPeripheral!, error: NSError!) {
        self.detailView.reloadData()
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
