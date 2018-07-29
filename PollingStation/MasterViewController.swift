//
//  MasterViewController.swift
//  PollingStation
//
//  Created by Gareth.K.Mensah on 5/5/18.
//  Copyright © 2018 Gareth.K.Mensah. All rights reserved.
//

import UIKit
import AWSAuthCore
import AWSAuthUI
import FoldingCell
import AWSDynamoDB
import Alertift
import SwiftyJSON


class MasterViewController: UITableViewController {

    var objects = [Any]()
    let kCloseCellHeight: CGFloat = 179
    let kOpenCellHeight: CGFloat = 488
    let kRowsCount = 10
    var cellHeights: [CGFloat] = []
    var service: CoinService?
    
    struct CoinInfo {
        var userId: String
        var backgroundImage: String
        var created: String
        var logoImage: String
        var name: String
        var purpose: String
        var symbol: String
        var totalPoints: NSNumber
        var type: String
        var voteCount: NSNumber
        var voteToday: NSNumber
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setToPeru(notification:)), name: .voteAlert, object: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "$", style: .plain, target: self, action: #selector(addTapped))
        
        if !AWSSignInManager.sharedInstance().isLoggedIn {
            AWSAuthUIViewController.presentViewController(with: self.navigationController!, configuration: nil, completionHandler: { (provider: AWSSignInProvider, error: Error?) in
                if error != nil {
                    print("Error occurred: \(String(describing: error))")
                }
            })
        } else {
            self.setup()
            
            let identityManager = AWSIdentityManager.default()
            let client: SUPCoinGateClient = SUPCoinGateClient.default()
            client.apiKey = "tHDIsk3QOp8ri94CKARO087WmI0QhYFW35otTCh7"
            client.getallcoinsGet().continueWith{ (task: AWSTask?) -> AnyObject? in
                if let error = task?.error {
                    print("Error occurred: \(error)")
                    return nil
                }
            
                if let result = task?.result {
                    let service = CoinService(JSONString: result as! String)
                    self.service = service!
                    self.refreshHandler()
                }
                
                return nil
            }

//            client.updatecoinsPost(userId: "0001", points: "100", id: "0002").continueWith{ (task: AWSTask?) -> AnyObject? in
//                if let error = task?.error {
//                    print("Error occurred: \(error)")
//                    return nil
//                }
//                
//                if let result = task?.result {
//                    //
//                }
//                return nil
//            }
//            
//            client.getvotesGet(id: identityManager.identityId!).continueWith{ (task: AWSTask?) -> AnyObject? in
//                if let error = task?.error {
//                    print("Error occurred: \(error)")
//                    return nil
//                }
//                
//                if let result = task?.result {
//                    //print("result: \(result.debugDescription)")
//                }
//                return nil
//            }
//            
//            client.createuserPost(userid: identityManager.identityId!).continueWith{ (task: AWSTask?) -> AnyObject? in
//                if let error = task?.error {
//                    print("Error occurred: \(error)")
//                    return nil
//                }
//                
//                if let result = task?.result {
//                    //print("result: \(result.debugDescription)")
//                }
//                return nil
//            }
        }
    }
    
    @objc private func addTapped() {
        
    }
    
    private func setup() {
        cellHeights = Array(repeating: kCloseCellHeight, count: kRowsCount)
        tableView.estimatedRowHeight = kCloseCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        if #available(iOS 10.0, *) {
            tableView.refreshControl = UIRefreshControl()
            tableView.refreshControl?.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
        }
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func setToPeru(notification: NSNotification) {
        self.showAlert()
    }
    
    func userVote() {
        let identityManager = AWSIdentityManager.default()
        let client: SUPCoinGateClient = SUPCoinGateClient.default()
        client.apiKey = "tHDIsk3QOp8ri94CKARO087WmI0QhYFW35otTCh7"
        client.usertokenvotePost(userid: identityManager.identityId!).continueWith{ (task: AWSTask?) -> AnyObject? in
            if let error = task?.error {
                print("usertoken Error occurred: \(error)")
                return nil
            }
            
            if let result = task?.result {
                print("result: \(result.debugDescription)")
            }
            return nil
        }
    }

    func showAlert() {
        Alertift.alert(title: "Vote", message: "Vote!")
            .actions(["A+", "A", "B", "C", "F"])
            .action(.cancel("Cancel"))
            .finally { action, index, arg in
                if action.style == .cancel { return }
                self.userVote()
            }
            .show(on: self)
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kRowsCount
    }
    
    override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }

    override func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as DemoCell = cell else {
            return
        }
        
        cell.backgroundColor = .clear
        
        if cellHeights[indexPath.row] == kCloseCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DemoCell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! DemoCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.containerView.layer.cornerRadius = 2
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        
        if let items = service?.items {
            cell.containerName.text = items[indexPath.row].name
            cell.containerSlogan.text = items[indexPath.row].purpose
            cell.containerText.text = items[indexPath.row].description
            cell.containerGrade.text = items[indexPath.row].grade
            cell.containerRank.text = items[indexPath.row].index.stringValue
            cell.containerVotes.text = items[indexPath.row].totalPoints.stringValue
            
            cell.descriptionName.text = items[indexPath.row].name
            cell.descriptionSymbol.text = items[indexPath.row].symbol
            cell.descriptionSlogan.text = items[indexPath.row].purpose
            cell.descriptionGrade.text = items[indexPath.row].grade
            cell.descriptionRank.text = items[indexPath.row].index.stringValue
            cell.descriptionVotes.text = items[indexPath.row].totalPoints.stringValue
            cell.descriptionText.text = items[indexPath.row].description
            
            let url = URL(string: items[indexPath.row].logoImage)
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    cell.descriptionLogoView.image = UIImage(data: data!)
                }
            }
            
            let url2 = URL(string: items[indexPath.row].backgroundImage)
            DispatchQueue.global().async {
                let data2 = try? Data(contentsOf: url2!)
                DispatchQueue.main.async {
                    cell.descriptionImageView.image = UIImage(data: data2!)
                }
            }

        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == kCloseCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
}

public extension Notification.Name {
    static let voteAlert = Notification.Name("voteAlert")
}

