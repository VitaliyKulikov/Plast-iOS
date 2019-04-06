//
//  CardModel.swift
//  StartPlast
//
//  Created by Kristina Del Rio Albrechet on 4/6/19.
//  Copyright © 2019 Plast. All rights reserved.
//

import Foundation

struct CardModel: Codable {
    
    enum State: Int {
        case locked = 1
        case unlocked
        case done
    }
    
    let id: Int
    let stateId: Int
    let iconId: Int
    let plastCoins: Int
    let title: String
    let description: String
    
    var state: State {
        return State(rawValue: stateId) ?? .unlocked
    }
}
