//
//  CelebrityModel.swift
//  CelScore
//
//  Created by Gareth.K.Mensah on 10/10/15.
//  Copyright © 2015 Gareth.K.Mensah. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper


final class CoinModel: StaticMappable {
    
    //MARK: Properties
    @objc dynamic var id: String = ""
    @objc dynamic var backgroundImage: String = ""
    @objc dynamic var created: String = ""
    @objc dynamic var logoImage: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var purpose: String = ""
    @objc dynamic var symbol: String = ""
    @objc dynamic var description: String = ""
    @objc dynamic var grade: String = ""
    @objc dynamic var totalPoints: NSNumber = 0
    @objc dynamic var type: String = ""
    @objc dynamic var voteCount: NSNumber = 0
    @objc dynamic var index: NSNumber = 0
    @objc dynamic var voteToday: NSNumber = 0
    
    
    //MARK: Initializer
    static func objectForMapping(map: Map) -> BaseMappable? {
        return CoinModel()
    }
    
    func mapping(map: Map) {
        self.id <- map["userId"]
        self.backgroundImage <- map["background_image"]
        self.created <- map["created"]
        self.logoImage <- map["logo_image"]
        self.name <- map["name"]
        self.description <- map["description"]
        self.grade <- map["grade"]
        self.purpose <- map["purpose"]
        self.symbol <- map["symbol"]
        self.index <- map["index"]
        self.totalPoints <- map["total_points"]
        self.type <- map["type"]
        self.voteCount <- map["vote_count"]
        self.voteToday <- map["vote_today"]
    }
}
