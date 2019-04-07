//
//  CardsDataService.swift
//  StartPlast
//
//  Created by Kristina Del Rio Albrechet on 4/6/19.
//  Copyright © 2019 Plast. All rights reserved.
//

import Foundation

class CardsDataService {
    static var shared = CardsDataService()
    
    func get(completion: (([CardModel]) -> Void)? = nil) {
        completion?([
            CardModel(index: 0, stateId: 3, plastCoins: 10, title: "First card", description: "This invitation was intended for kalbrechet@gmail.com. If you were not expecting this invitation, you can ignore this email. If @VitaliyKulikov is sending you too many emails, you can block them or report abuse."),
            CardModel(index: 1, stateId: 2, plastCoins: 10, title: "First card", description: "This invitation was intended for kalbrechet@gmail.com. If you were not expecting this invitation, you can ignore this email. If @VitaliyKulikov is sending you too many emails, you can block them or report abuse."),
            CardModel(index: 2, stateId: 1, plastCoins: 10, title: "First card", description: "This invitation was intended for kalbrechet@gmail.com. If you were not expecting this invitation, you can ignore this email. If @VitaliyKulikov is sending you too many emails, you can block them or report abuse."),
            CardModel(index: 3, stateId: 1, plastCoins: 10, title: "First card", description: "This invitation was intended for kalbrechet@gmail.com. If you were not expecting this invitation, you can ignore this email. If @VitaliyKulikov is sending you too many emails, you can block them or report abuse.")
            ])
    }
}
