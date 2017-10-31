//
//  ViewController.swift
//  Levler for Doctors
//
//  Created by Mohak on 14/10/17.
//  Copyright © 2017 Mohak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var iconClick : Bool!

    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBAction func toggleButton(_ sender: Any) {
        if(iconClick == true) {
            passwordTF.isSecureTextEntry = false
            iconClick = false
            eyeButton.setImage(UIImage(named: "001-interface"), for: UIControlState.normal)
        } else {
            passwordTF.isSecureTextEntry = true
            iconClick = true
            
            eyeButton.setImage(UIImage(named: "003-medical"), for: UIControlState.normal )
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        iconClick = true
        messageLabel.isHidden = true
        
        UITextField.appearance().tintColor = UIColor(red: 96/255, green: 189/255, blue: 106/255, alpha: 1.0)
        
        
        //self.hideKeyboardWhenTappedAround()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
}

