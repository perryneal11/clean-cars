//
//  SignUpViewController.swift
//  Clean Cars
//
//  Created by Neal, Perry (P.) on 1/20/21.
//  Copyright © 2021 Neal, Perry (P.). All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    @IBOutlet weak var agreement: UISwitch!
    
    @IBAction func aignUpAction(_ sender: Any) {
        
        if agreement.isOn == false {
            let alertController = UIAlertController(title: "Service Agreement", message: "Please agree to terms and service and privacy policy", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            if password.text != passwordConfirm.text {
                let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                }
            else {
                Auth.auth().createUser(withEmail: email.text!, password: password.text!){
                    (user, error) in if error == nil {
                        self.performSegue(withIdentifier: "signupToHome", sender: self)
                    }
                    else{
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}

