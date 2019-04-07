//
//  LoginViewController.swift
//  StartPlast
//
//  Created by Viktor Rudyk on 4/6/19.
//  Copyright © 2019 Plast. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    
    
    @IBOutlet private weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
//        GIDSignIn.sharedInstance()?.delegate = self
    }
}

extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        let email = user.profile.email
        let name = user.profile.name
        let familyName = user.profile.familyName
        let givenName = user.profile.givenName
        let avatarURL = user.profile.imageURL(withDimension: 300)
        
        
        
        let db = Database.database().reference()
        
        
        
        let ref2 = db.child(DBKeys.users).child("12345")
        ref2.setValue([DBKeys.name: name,
                       DBKeys.avatar: avatarURL?.absoluteString,
                       DBKeys.mail: email,
                       DBKeys.currentStep: 1,
                       DBKeys.coins: 100])
    }
    
    func testDB() {
        let user = Auth.auth().currentUser
        if let user = user {
            // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with your backend server,
            // if you have one. Use getTokenWithCompletion:completion: instead.
            let uid = user.uid
            let email = user.email
            let photoURL = user.photoURL
            // ...
        }
        
        let db = Database.database().reference()
        
        print()
        
        let ref = db.child("message")
        
        ref.observe(DataEventType.value, with: { (snapshot) in
            print(snapshot)
            // ...
        })
        
        let ref2 = db.child("users").child("dakhdkahksd")
        
        ref2.observe(DataEventType.value, with: { (snapshot) in
            print(snapshot)
            // ...
        })
        
        ref2.child("coins").setValue(308)
        ref2.observeSingleEvent(of: .value, with: { (snapshot) in
            if let userDict = snapshot.value as? [String:Any] {
                //Do not cast print it directly may be score is Int not string
                print(userDict["score"])
            }
        })
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
