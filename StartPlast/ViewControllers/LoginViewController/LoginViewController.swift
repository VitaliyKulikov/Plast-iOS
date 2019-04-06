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
        //GIDSignIn.sharedInstance().signIn()

    }
    

}
