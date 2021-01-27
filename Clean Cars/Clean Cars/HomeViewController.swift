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

class HomeViewController: UIViewController, UITableViewDataSource {
    let ref: DatabaseReference! = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    var cleaningDictionary: [String : String] = [:]
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        ref.child("users").child(userID!).child("cleanings").observeSingleEvent(of: .value) { (DataSnapshot) in
                print(DataSnapshot)

                let enumerator = DataSnapshot.children
                while let rest = enumerator.nextObject() as? DataSnapshot {
                    let cleaningDictionary = rest.value as? [String : AnyObject] ?? [:]
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData();
                }
            }
        }
    
        func tableView(_ tableView:UITableView!, numberOfRowsInSection section:Int) -> Int
         {
            return cleaningDictionary.count + 1
         }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           // Reuse or create a cell.
           let cell = tableView.dequeueReusableCell(withIdentifier: "cleaningCell", for: indexPath)

            if cleaningDictionary.isEmpty{
                cell.textLabel!.text = "You have no cleanings scheduled"
            }
            else if !cleaningDictionary.isEmpty{
                var cleaningString: String = "Hello"
                cell.textLabel!.text = cleaningString


            }


           return cell
        }
    

  


        
        
    }


