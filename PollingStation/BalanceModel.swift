//
//  BalanceModel.swift
//  PollingStation
//
//  Created by Gareth.K.Mensah on 8/5/18.
//  Copyright © 2018 Gareth.K.Mensah. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper


final class BalanceModel: StaticMappable {
    
    //MARK: Properties
    @objc dynamic var id: String = ""
    @objc dynamic var from: String = ""
    @objc dynamic var hash: String = ""
    @objc dynamic var time: String = ""
    @objc dynamic var status: String = ""
    @objc dynamic var amount: String = ""
    @objc dynamic var block_number: String = ""
    
    
    //MARK: Initializer
    static func objectForMapping(map: Map) -> BaseMappable? {
        return BalanceModel()
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.from <- map["from_user_id"]
        self.hash <- map["transaction_hash"]
        self.time <- map["timestamp"]
        self.status <- map["status"]
        self.amount <- map["amount"]
        self.block_number <- map["block_number"]
    }
}
