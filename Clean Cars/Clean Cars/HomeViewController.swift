//
//  HomeViewController.swift
//  Clean Cars
//
//  Created by Neal, Perry (P.) on 1/20/21.
//  Copyright © 2021 Neal, Perry (P.). All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        var cleanings = [String]()
        var message = String()
        
        
        
        ref.child("users").child(userID!).child("cleanings").child("1").observeSingleEvent(of: .value) { (DataSnapshot) in
            print(DataSnapshot)
            let cleaning = DataSnapshot.value as? String
            if let actualCleaning = cleaning{
                cleanings.append(actualCleaning)
                print(cleanings)
                
            }
            
        }
        
        
        
    }

}

