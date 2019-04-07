//
//  ProfileDataService.swift
//  StartPlast
//
//  Created by Kristina Del Rio Albrechet on 4/6/19.
//  Copyright © 2019 Plast. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class ProfileDataService {
    enum DBError: Swift.Error {
        case profileIsMissing
        case writeError
        case unknown(String?)
        
        public var localizedDescription: String {
            switch self {
            case .profileIsMissing:
                return "Відсутній профайл користувача"
            case .writeError:
                return "Помилка запису в базу даних"
            case .unknown(let message):
                return message ?? "Щось пішло не так"
            }
        }
    }
    enum DBKeys {
        static let users = "users"
        static let avatar = "avatar"
        static let coins = "coins"
        static let currentStep = "current_step"
        static let mail = "mail"
        static let name = "name"
    }
    
    static var shared = ProfileDataService()

    private(set) var currentProfile: ProfileModel? = nil
    
    private let dbReference = Database.database().reference()
    
    enum Result<T> {
        case success(T)
        case failure(Error)
    }
    
    func completeCard(_ card: CardModel, completion: @escaping (Result<ProfileModel>) -> Void) {
        guard let currentProfile = self.currentProfile else {
            completion(.failure(DBError.profileIsMissing))
            return
        }
        
        let currentStep = currentProfile.currentStep + 1
        
        dbReference.child(DBKeys.users).child("\(currentProfile.id)").child(DBKeys.currentStep).setValue(currentStep) { [weak self] (error, dbRecordReference) in
            guard error == nil else {
                completion(.failure(DBError.writeError))
                return
            }
            
            self?.getCurrentProfile(completion: { (result) in
                completion(result)
            })
        }
        
        // TODO:
        
        // increment coins (add CardDataServive.shared.get()[oldIndex] to profileModel.coins)
        
    }

    func getCurrentProfile(completion: @escaping (Result<ProfileModel>) ->Void) {
        guard let currentProfile = self.currentProfile else {
            completion(.failure(DBError.profileIsMissing))
            return
        }
        
        dbReference.child(DBKeys.users).child(currentProfile.id).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let userDict = snapshot.value as? [String:Any],
                let profile = ProfileModel.init(with: userDict, profileId: currentProfile.id) else {
                completion(.failure(DBError.profileIsMissing))
                return
            }
            
            completion(.success(profile))
            
        })
        
        // FIXME:
        completion(.success(ProfileModel(
            id: "123",
            username: "Kristina Del Rio Albrechet",
            email: "kalbrechet@gmail.com",
            avatarUrl: URL(string: "https://cdn-images-1.medium.com/fit/c/200/200/1*8EAtAFUVRiK1btuFhLnE1Q@2x.jpeg")!,
            currentStep: 2,
            coins: 0)))
    }
    
    func getProfile(with profileId: String, completion: @escaping (Result<ProfileModel>) ->Void) {
        dbReference.child(DBKeys.users).child(profileId).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let userDict = snapshot.value as? [String:Any],
                let profile = ProfileModel.init(with: userDict, profileId: profileId) else {
                    completion(.failure(DBError.profileIsMissing))
                    return
            }
            
            completion(.success(profile))
        })
    }
    
    func setCurrentProfile(_ profile: ProfileModel) {
        self.currentProfile = profile
    }
    
    func registerUser(with profile: ProfileModel, completion: @escaping (Result<ProfileModel>) -> Void) {
        let profileDictionary = profile.parametersDictionary()
        
        dbReference.child(DBKeys.users).child("\(profile.id)").setValue(profileDictionary) {[weak self] (error, dbRecordReference) in
            guard error == nil else {
                completion(.failure(DBError.writeError))
                return
            }
            
            self?.getProfile(with: profile.id, completion: { (result) in
                completion(result)
            })
        }
    }
    
    //MARK: Private methods
}
