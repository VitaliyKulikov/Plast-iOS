//
//  ViewController.swift
//  StartPlast
//
//  Created by Dmytro Skorokhod on 4/6/19.
//  Copyright © 2019 Plast. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.performSegue(withIdentifier: "LoginIdentifier", sender: self)
    }
}

