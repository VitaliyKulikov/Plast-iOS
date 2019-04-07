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
import MBProgressHUD

class LoginViewController: UIViewController,  GIDSignInUIDelegate {
    
    private static let kMainProgramId = "CarouselIdentifier"
    
    @IBOutlet private weak var signInControl: UIControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    @IBAction private func sinInPressed(_ sender: UIControl) {
        GIDSignIn.sharedInstance()?.signIn()
    }
}

extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn, didSignInFor user: GIDGoogleUser, withError error: Error) {
        
        guard error == nil else {
            print(error.localizedDescription)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        MBProgressHUD.showAnimated(onView: self.view)
        Auth.auth().signInAndRetrieveData(with: credential) {[weak self] (authResult, error) in
            if let error = error {
                MBProgressHUD.hideAnimated(forView: self?.view)
                return
            }
            guard let user = authResult?.user else {
                MBProgressHUD.hideAnimated(forView: self?.view)
                return
            }
            let userId = user.uid
            
            ProfileDataService.shared.getProfile(with: userId, completion: { (result) in
                switch result {
                case .failure(let error):
                    MBProgressHUD.hideAnimated(forView: self?.view)
                    print(error)
                    
                    guard let email = user.email,
                    let name = user.displayName,
                        let avatarURL = user.photoURL else {
                            fatalError()
                    }
                    
                    let profileModelToRegister = ProfileModel.init(id: userId, username: name, email: email, avatarUrl: avatarURL, currentStep: 0, coins: 0)
                    MBProgressHUD.showAnimated(onView: self?.view)
                    ProfileDataService.shared.registerUser(with: profileModelToRegister, completion: { (result) in
                        MBProgressHUD.hideAnimated(forView: self?.view)
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
