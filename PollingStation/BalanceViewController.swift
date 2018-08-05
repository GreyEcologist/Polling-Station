//
//  BalanceViewController.swift
//  PollingStation
//
//  Created by Gareth.K.Mensah on 8/1/18.
//  Copyright © 2018 Gareth.K.Mensah. All rights reserved.
//

import UIKit
import AWSAuthCore
import AWSAuthUI
import SwiftyJSON

class BalanceViewController: UITableViewController {
    
     var service: BalanceService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userVote()
    }
    
    func userVote() {
        let client: TRUCoinGateClient = TRUCoinGateClient.default()
        client.apiKey = "tHDIsk3QOp8ri94CKARO087WmI0QhYFW35otTCh7"
        client.getbalancePost(id: "0001").continueWith{ (task: AWSTask?) -> AnyObject? in
            if let error = task?.error {
                print("usertoken Error occurred: \(error)")
                return nil
            }
            
            if let result = task?.result {
                let service = BalanceService(JSONString: result as! String)
                self.service = service!
                print("A: \(result))")
                print("B: \(self.service!.data!.transactions!.count)")
                //self.refreshHandler()
            }
            return nil
        }
    }
    
    @IBAction func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func refreshHandler() {
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: { [weak self] in
            if #available(iOS 10.0, *) {
                self?.tableView.refreshControl?.endRefreshing()
            }
            self?.tableView.reloadData()
        })
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 { return "Balance" }
        else { return "History" }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1}
        else { return 10 }
    }
    
    override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
}
