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
