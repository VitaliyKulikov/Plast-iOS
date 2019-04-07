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
    
    private static let kMainProgramId = "CarouselIdentifier"
    
    @IBOutlet private weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
}

extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signInAndRetrieveData(with: credential) {[weak self] (authResult, error) in
            if let error = error {
                // ...
                return
            }
            guard let user = authResult?.user else {
                return
            }
            let userId = user.uid
            
            ProfileDataService.shared.getProfile(with: userId, completion: { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                    
                    guard let email = user.email,
                    let name = user.displayName,
                        let avatarURL = user.photoURL else {
                            fatalError()
                    }
                    
                    let profileModelToRegister = ProfileModel.init(id: userId, username: name, email: email, avatarUrl: avatarURL, currentStep: 0, coins: 0)
                    ProfileDataService.shared.registerUser(with: profileModelToRegister, completion: { (result) in
                        switch result {
                        case .failure(let error):
                            fatalError()
                        case .success(let profile):
                            self?.finishSingIn(with: profile)
                        }
                    })
                case .success(let profile):
                    self?.finishSingIn(with: profile)
                }
            })
        }
        
    }
    
    private func finishSingIn(with profile: ProfileModel) {
        ProfileDataService.shared.setCurrentProfile(profile)
        self.performSegue(withIdentifier: LoginViewController.kMainProgramId, sender: profile)
    }
}

extension LoginViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == LoginViewController.kMainProgramId,
            let controller = segue.destination as? MainProgramController,
            let model = sender as? ProfileModel {
            controller.profileModel = model
        }
    }
}
