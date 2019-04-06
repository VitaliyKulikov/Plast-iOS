//
//  ProfileDataService.swift
//  StartPlast
//
//  Created by Kristina Del Rio Albrechet on 4/6/19.
//  Copyright © 2019 Plast. All rights reserved.
//

import Foundation

class ProfileDataService {
    
    static var shared = ProfileDataService()
    
    var currentProfile: ProfileModel? = nil
    
    enum Result {
        case success
        case failure(Error)
    }
    
    func incrementCurrentCardIndex(completion: ((Result) -> Void)?) {
        // TODO:
        // increment idx
        // increment coins (add CardDataServive.shared.get()[oldIndex] to profileModel.coins)
        completion?(.success)
    }

    func get(completion: ((ProfileModel) -> Void)? = nil) {
        // FIXME:
        completion?(ProfileModel(
            username: "Kristina Del Rio Albrechet",
            email: "kalbrechet@gmail.com",
            avatarUrl: URL(string: "https://cdn-images-1.medium.com/fit/c/200/200/1*8EAtAFUVRiK1btuFhLnE1Q@2x.jpeg")!,
            coins: 0))
    }
}
