//
//  CardsDataService.swift
//  StartPlast
//
//  Created by Kristina Del Rio Albrechet on 4/6/19.
//  Copyright © 2019 Plast. All rights reserved.
//

import Foundation
import SwiftyJSON

class CardsDataService {
    static var shared = CardsDataService()
    
    func get(completion: (([CardModel]) -> Void)? = nil) {
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try JSON(data: data)
                
                if let cardJsons = json["cards"].arrayObject {
                    let cards = cardJsons.map ({CardModel(json: $0 as! [String: AnyObject])})
                    updateStates(for: cards, completion: completion)
                } else {
                    completion?([])
                }
            } catch let err {
                print(err.localizedDescription)
                completion?([])
            }
        }
        completion?([])
    }
    
    private func updateStates(for cards: [CardModel],
                              completion: (([CardModel]) -> Void)? = nil) {
        
        ProfileDataService.shared.getCurrentProfile { (result) in
            switch result {
            case .failure(let err):
                print(err.localizedDescription)
                completion?([])
                
            case .success(let model):
                completion?(cards.map{
                    var card = $0
                    if model.currentStep ==  $0.index {
                        card.state = .current
                    } else if model.currentStep > $0.index {
                        card.state = .done
                    } else {
                        card.state = .locked
                    }
                    return card
                })
            }
        }
    }
}
