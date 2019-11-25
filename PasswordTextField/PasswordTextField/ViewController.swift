//
//  ViewController.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/25/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func returnTapped(_ sender: PasswordField) {
        self.view.endEditing(true)
        print("Password: \(sender.password), Strength: \(sender.passwordStrength)")
    }
}
