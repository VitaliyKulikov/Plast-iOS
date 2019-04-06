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
        //GIDSignIn.sharedInstance().signIn()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            self.performSegue(withIdentifier: LoginViewController.kMainProgramId,
                         sender:  ProfileModel(
                            username: "Kristina Del Rio Albrechet",
                            email: "kalbrechet@gmail.com",
                            avatarUrl: URL(string: "https://cdn-images-1.medium.com/fit/c/200/200/1*8EAtAFUVRiK1btuFhLnE1Q@2x.jpeg")!,
                            coins: 0))
        }
        
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
