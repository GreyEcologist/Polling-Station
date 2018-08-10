//
//  TransactionCell.swift
//  PollingStation
//
//  Created by Gareth.K.Mensah on 8/6/18.
//  Copyright © 2018 Gareth.K.Mensah. All rights reserved.
//

import Foundation

class TransactionCell: UITableViewCell {
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class WalletCell: UITableViewCell {
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
