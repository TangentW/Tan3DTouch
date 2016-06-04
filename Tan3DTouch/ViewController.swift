//
//  ViewController.swift
//  Tan3DTouch
//
//  Created by Tan on 16/6/4.
//  Copyright © 2016年 Tangent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //  MARK: - Property
    private static let tableViewCellIdentifier = "ViewControllerCellidentifier"

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: .Plain)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: ViewController.tableViewCellIdentifier)
        return tableView
    }()
    
    private lazy var tableViewData: [String] = {
        return ["Hello", "My", "Name", "Is", "Tangent"]
    }()
    
    //  MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //  MARK: - Setup 3D Touch
        if self.traitCollection.forceTouchCapability == .Available {
            self.registerForPreviewingWithDelegate(self, sourceView: self.tableView)
        } else {
            print("3D Touch 不可用!")
        }
    }
}

//  MARK: - TableView DataSource & Delegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ViewController.tableViewCellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = self.tableViewData[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let detailViewController = DetailViewController()
        detailViewController.mainTitle = self.tableViewData[indexPath.row]
        
        dispatch_async(dispatch_get_main_queue()) {
            self.navigationController!.pushViewController(detailViewController, animated: true)
        }
    }
}

//  MARK: - UIViewControllerPreviewingDelegate
extension ViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = self.tableView.indexPathForRowAtPoint(location) else { return nil }
        let selectedCellFrame = tableView.cellForRowAtIndexPath(indexPath)!.frame
        
        let detailViewController = DetailViewController()
        detailViewController.mainTitle = self.tableViewData[indexPath.row]
        detailViewController.preferredContentSize = CGSize(width: 0.0, height: 350)
        
        previewingContext.sourceRect = selectedCellFrame
        
        return detailViewController
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        self.showViewController(viewControllerToCommit, sender: self)
    }
}
