//
//  CountryViewController.swift
//  News
//
//  Created by Doaa Tantawy on 8/6/19.
//  Copyright © 2019 Doaa Tantawy. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {

    @IBOutlet weak var enteredCode: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        var newsTableVC : NewsTableViewController = segue.destination as! NewsTableViewController
        newsTableVC.countryCodeUrl = enteredCode.text ?? "us"
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
 

}
