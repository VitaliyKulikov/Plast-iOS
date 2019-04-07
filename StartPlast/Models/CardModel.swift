//
//  CardModel.swift
//  StartPlast
//
//  Created by Kristina Del Rio Albrechet on 4/6/19.
//  Copyright © 2019 Plast. All rights reserved.
//

import Foundation

struct CardModel {
    
    enum State: Int {
        case locked = 1
        case current
        case done
    }
    
    let index: Int
    let plastCoins: Int
    let title: String
    let description: String
    var state: State = .locked
    
    init(json: [String : AnyObject]) {
        index = json["index"] as? Int ?? 0
        plastCoins = json["coins"] as? Int ?? 0
        title = json["title"] as? String ?? ""
        description = json["description"] as? String ?? ""
    }
}
