//
//  ProfileModel.swift
//  StartPlast
//
//  Created by Kristina Del Rio Albrechet on 4/6/19.
//  Copyright © 2019 Plast. All rights reserved.
//

import Foundation

struct ProfileModel {
    let id: String
    let username: String
    let email: String
    let avatarUrl: URL
    private(set) var currentStep: Int
    let coins: Int 
}

extension ProfileModel {
    func parametersDictionary() -> [String: Any] {
        
        return [ProfileDataService.DBKeys.name: username,
                ProfileDataService.DBKeys.avatar: avatarUrl.absoluteString,
                ProfileDataService.DBKeys.mail: email,
                ProfileDataService.DBKeys.currentStep: currentStep,
                ProfileDataService.DBKeys.coins: coins]
    }
    
    init?(with dictionary: [String: Any], profileId: String){
        guard let username = dictionary[ProfileDataService.DBKeys.name] as? String else {
            return nil
        }
        guard let email = dictionary[ProfileDataService.DBKeys.mail] as? String else {
            return nil
        }
        guard let avatarString = dictionary[ProfileDataService.DBKeys.avatar] as? String, let avatarUrl = URL(string: avatarString) else {
            return nil
        }
        guard let currentStep = dictionary[ProfileDataService.DBKeys.currentStep] as? Int else {
            return nil
        }
        guard let coins = dictionary[ProfileDataService.DBKeys.coins] as? Int else {
            return nil
        }
        self.init(id: profileId, username: username, email: email, avatarUrl: avatarUrl, currentStep: currentStep, coins: coins)
    }
}
