//
//  addVehicleViewController.swift
//  Clean Cars
//
//  Created by Neal, Perry (P.) on 1/20/21.
//  Copyright © 2021 Neal, Perry (P.). All rights reserved.
//

import UIKit

class addVehicleViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    var selectedMake: String?
    var makeList = ["Ford", "GM"]
    @IBOutlet weak var makeTextView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            createPickerView()
            dismissPickerView()
            getMakeData()
        }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return makeList.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return makeList[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMake = makeList[row]
        makeTextView.text = selectedMake
    }
    
    func createPickerView() {
           let pickerView = UIPickerView()
           pickerView.delegate = self
           makeTextView.inputView = pickerView
    }
    func dismissPickerView() {
       let toolBar = UIToolbar()
       toolBar.sizeToFit()
       let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
       toolBar.setItems([button], animated: true)
       toolBar.isUserInteractionEnabled = true
       makeTextView.inputAccessoryView = toolBar
    }
    
    func getMakeData() -> () {
        guard let url = URL(string: "https://vpic.nhtsa.dot.gov/api/vehicles/getallmakes?format=json") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let dataResponse = data,
                  error == nil else {
                  print(error?.localizedDescription ?? "Response Error")
                  return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                                       dataResponse, options: [])
                //print(jsonResponse) //Response result
                //print(jsonResponse)
                guard let jsonArray = jsonResponse as? [String: Any] else {
                      return
                }
                //print(jsonArray["Results"])
                //print(type(of: jsonArray))
                guard let result = jsonArray["Results"] as? [[String : Any]] else {
                    //print("failed to parse jsonArray")
                    return }
                //print(result)
                for e in result{
                    guard let make = e["Make_Name"] as? String else { return }
                    //print(make) //Output
                    self.makeList.append(make)
                }//compiler outout -  delectus aut autem
             } catch let parsingError {
                print("Error", parsingError)
           }
        }
        task.resume()
        
    }
    
    @objc func action() {
       view.endEditing(true)
    }

}

