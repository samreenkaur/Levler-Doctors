//
//  ViewController.swift
//  Levler for Doctors
//
//  Created by Mohak on 14/10/17.
//  Copyright © 2017 Mohak. All rights reserved.
//
// 26b75b

import UIKit
import Alamofire

class ViewController: UIViewController {
    var iconClick : Bool!
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var loadingView: UIView = UIView()
    
    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    let defaultValues = UserDefaults.standard

    
    @IBAction func signInBt(_ sender: Any) {
        print(emailTF.text as Any)
        print(passwordTF.text as Any)
        let params: [String: String] = ["email": emailTF.text!, "password": passwordTF.text!]
         showActivityIndicator()
    Alamofire.request("https://app.levler.co/api/v1/fleet/login", method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json"]).validate().responseJSON { response in
            //print(response)
            // print("Code: \(response.response?.statusCode)")
            self.hideActivityIndicator()
            switch response.result {
            case .success:
                
                let jsonData = response.result.value as! NSDictionary
                
                //getting user values
                let location_id = jsonData.value(forKey: "location_id") as! Int
                let team_goal = jsonData.value(forKey: "team_goal") as! Int32
                let token = jsonData.value(forKey: "token") as! String
                
                //saving user values to defaults
                self.defaultValues.set(location_id, forKey: "location_id")
                self.defaultValues.set(team_goal, forKey: "team_goal")
                self.defaultValues.set(token, forKey: "token")
                
                print("location: \(location_id)")
                print("teamgoal: \(team_goal)")
                print("token: \(token)")
                //switching the screen
                
                //print("Validation Successful")
                
                self.loginSuccess()
                self.messageLabel.isHidden = true
                
            case .failure:
                //print(error)
                self.messageLabel.isHidden = false
                self.messageLabel.text = "Invalid email or password."
            }
        }
    }
    
    func loginSuccess(){
        let homeViewController: UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        //self.navigationController?.pushViewController(homeViewController, animated: true)
        let navController: UINavigationController = UINavigationController(rootViewController: homeViewController)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().backgroundColor = UIColor.black
        UIApplication.shared.keyWindow?.rootViewController = navController
        
        self.dismiss(animated: false, completion: nil)
        
    }
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
        
        UITextField.appearance().tintColor = UIColor(red: 38/255, green: 183/255, blue: 91/255, alpha: 1.0)
        
        
        self.hideKeyboardWhenTappedAround()
        
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
    func showActivityIndicator() {
        
        DispatchQueue.main.async {
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            self.loadingView.center = self.view.center
            self.loadingView.backgroundColor = UIColor.lightGray
            self.loadingView.alpha = 0.9
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10
            self.view.alpha = 0.5
            self.spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)
            
            self.loadingView.addSubview(self.spinner)
            self.view.addSubview(self.loadingView)
            self.spinner.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.view.alpha = 1

            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }
}

