//
//  RefreshCollectionViewController.swift
//  UIRefreshControlDemo
//
//  Created by fkm on 2016/02/21.
//  Copyright © 2016年 mokelab. All rights reserved.
//

import UIKit

class RefreshCollectionViewController : UIViewController, UICollectionViewDataSource {
    @IBOutlet var collectionView : UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "startLoading:", forControlEvents: UIControlEvents.ValueChanged)
        collectionView?.addSubview(refreshControl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UICollectionView Data source
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }


    //MARK: RefreshControl
    func startLoading(refreshControl : UIRefreshControl) {
        NSThread.detachNewThreadSelector("wait:", toTarget: self, withObject: refreshControl)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        return cell
    }

    
    func wait(refreshControl : UIRefreshControl) {
        // 2 sec
        sleep(2)
        dispatch_async(dispatch_get_main_queue()) {
            refreshControl.endRefreshing()
        }
    }
}
