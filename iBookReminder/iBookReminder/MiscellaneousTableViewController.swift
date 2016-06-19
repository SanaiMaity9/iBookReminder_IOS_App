//
//  MiscellaneousTableViewController.swift
//  iBookReminder
//
//  Created by Manish on 12/11/15.
//  Copyright (c) 2015 ifconit. All rights reserved.
//

import UIKit

class MiscellaneousTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0){
            return CGFloat(0)
        }
        return CGFloat(22);
    }

   }
