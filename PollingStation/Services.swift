//
//  Services.swift
//  CelScore
//
//  Created by Gareth.K.Mensah on 10/31/17.
//  Copyright © 2017 Gareth.K.Mensah. All rights reserved.
//

import Foundation
import ObjectMapper


final class CoinService: NSObject, Mappable {
    var items: [CoinModel]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        items <- map["Items"]
    }
}

final class BalanceService: NSObject, Mappable {
    var data: PSData?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}

final class PSData: NSObject, Mappable {
    var transactions: [BalanceModel]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        transactions <- map["transactions"]
    }
}

final class WalletService: NSObject, Mappable {
    var data: PSWallet?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}

final class PSWallet: NSObject, Mappable {
    var balance: PSBalance?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        balance <- map["balance"]
    }
}

final class PSBalance: NSObject, Mappable {
    var available_balance: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        available_balance <- map["available_balance"]
    }
}
