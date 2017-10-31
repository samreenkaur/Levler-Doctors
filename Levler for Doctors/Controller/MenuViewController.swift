//
//  MenuViewController.swift
//  Levler for Doctors
//
//  Created by Mohak on 15/10/17.
//  Copyright © 2017 Mohak. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    @IBAction func sentInviteButtonClicked(_ sender: Any) {
        
    }
    
    @IBAction func RateOurApp(_ sender: Any) {
        openURL(urlStr: "itms-apps://itunes.apple.com/app/co.levler/levler/id1293043752")
    }
    
    @IBAction func logout(_ sender: Any) {
        print("LOGOUT SUCCESS")
        //PFUSer.logout()
        let defaultValues = UserDefaults.standard
        
        defaultValues.set(nil, forKey: "token")
        let token = defaultValues.string(forKey: "token")
        print(token as Any)
        print("LOGIN AGAIN")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Login = storyboard.instantiateViewController(withIdentifier: "viewController")
        self.present(Login, animated: true, completion: nil)
      
        
    }
    
    
    func openURL(urlStr:String!) {
        
        if let url = NSURL(string:urlStr) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
