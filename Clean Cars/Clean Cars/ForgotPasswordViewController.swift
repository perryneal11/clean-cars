//
//  ForgotPasswordViewController.swift
//  Clean Cars
//
//  Created by Neal, Perry (P.) on 1/20/21.
//  Copyright © 2021 Neal, Perry (P.). All rights reserved.
//

import UIKit
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var email: UITextField!
    
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
        
        Auth.auth().sendPasswordReset(withEmail: email.text!) { error in
          let alertController = UIAlertController(title: "Password Reset Sent", message: "If an account exists, a password reset email will be sent.", preferredStyle: .alert)
          let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
          alertController.addAction(defaultAction)
          self.present(alertController, animated: true, completion: nil)
                  
        }



        
    }
    
    
}

