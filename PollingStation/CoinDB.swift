//
//  CoinDB.swift
//  MySampleApp
//
//
// Copyright 2018 Amazon.com, Inc. or its affiliates (Amazon). All Rights Reserved.
//
// Code generated by AWS Mobile Hub. Amazon gives unlimited permission to 
// copy, distribute and modify it.
//
// Source code generated from template: aws-my-sample-app-ios-swift v0.21
//

import Foundation
import UIKit
import AWSDynamoDB


class CoinDB: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    var _userId: String?
    var _backgroundImage: String?
    var _created: String?
    var _logoImage: String?
    var _name: String?
    var _purpose: String?
    var _symbol: String?
    var _totalPoints: NSNumber?
    var _type: String?
    var _voteCount: NSNumber?
    var _voteToday: NSNumber?
    
    class func dynamoDBTableName() -> String {

        return "pollingstation-mobilehub-1632318331-CoinDB"
    }
    
    class func hashKeyAttribute() -> String {

        return "_userId"
    }
    
    override class func jsonKeyPathsByPropertyKey() -> [AnyHashable: Any] {
        return [
               "_userId" : "userId",
               "_backgroundImage" : "background_image",
               "_created" : "created",
               "_logoImage" : "logo_image",
               "_name" : "name",
               "_purpose" : "purpose",
               "_symbol" : "symbol",
               "_totalPoints" : "total_points",
               "_type" : "type",
               "_voteCount" : "vote_count",
               "_voteToday" : "vote_today",
        ]
    }
}