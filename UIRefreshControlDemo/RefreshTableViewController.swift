//
//  RefreshTableViewController.swift
//  UIRefreshControlDemo
//
//  Created by fkm on 2016/02/20.
//  Copyright © 2016年 mokelab. All rights reserved.
//

import UIKit

class RefreshTableViewController : UIViewController, UITableViewDataSource {
    @IBOutlet var tableView : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "startLoading:", forControlEvents: UIControlEvents.ValueChanged)
        tableView?.addSubview(refreshControl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: TableView Data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("line") as UITableViewCell!
        cell.textLabel!.text = "Line \(indexPath.row)"
        return cell
    }
    
    //MARK: RefreshControl
    func startLoading(refreshControl : UIRefreshControl) {
        NSThread.detachNewThreadSelector("wait:", toTarget: self, withObject: refreshControl)
    }
    
    func wait(refreshControl : UIRefreshControl) {
        // 2 sec
        sleep(2)
        dispatch_async(dispatch_get_main_queue()) {
            refreshControl.endRefreshing()
        }
    }

}
