//
//  DemoCell.swift
//  FoldingCell
//
//  Created by Alex K. on 25/12/15.
//  Copyright © 2015 Alex K. All rights reserved.
//

import FoldingCell
import UIKit


class DemoCell: FoldingCell {

    @IBOutlet var containerRank: UILabel!
    @IBOutlet var containerGrade: UILabel!
    @IBOutlet var containerVotes: UILabel!
    @IBOutlet var containerName: UILabel!
    @IBOutlet var containerSlogan: UILabel!
    @IBOutlet var containerText: UILabel!
    
    @IBOutlet var descriptionRank: UILabel!
    @IBOutlet var descriptionGrade: UILabel!
    @IBOutlet var descriptionVotes: UILabel!
    @IBOutlet var descriptionName: UILabel!
    @IBOutlet var descriptionSlogan: UILabel!
    @IBOutlet var descriptionText: UILabel!
    @IBOutlet var descriptionSymbol: UILabel!
    @IBOutlet var descriptionToday: UILabel!
    @IBOutlet var descriptionImageView: UIImageView!
    @IBOutlet var descriptionLogoView: UIImageView!
    

    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex:NSInteger, type: AnimationType) -> TimeInterval {
        let durations = [0.33, 0.26, 0.26]
        return durations[itemIndex]
    }
}

// MARK: - Actions ⚡️

extension DemoCell {

    @IBAction func buttonHandler(_: AnyObject) {
        NotificationCenter.default.post(name: .voteAlert, object: nil)
    }
    
}

