//
//  SentInviteDetailsTableViewController.swift
//  Levler for Doctors
//
//  Created by Mohak on 14/10/17.
//  Copyright © 2017 Mohak. All rights reserved.
//

import UIKit
import Alamofire
class SentInviteDetailsTableViewController: UITableViewController {
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var loadingView: UIView = UIView()
    
    struct Invites {
        let name : String
        let phone : String
        let time : String
    }
    
    func showActivityIndicator() {
        
        DispatchQueue.main.async {
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            self.loadingView.center = self.view.center
            self.loadingView.backgroundColor = UIColor.lightGray
            self.loadingView.alpha = 0.7
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10
            
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
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }
    let noDataLabel: UILabel  = UILabel()
    
    func noData(){
        DispatchQueue.main.async {
            self.noDataLabel.frame  = CGRect(x: 0.0, y: 0.0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height)
            self.noDataLabel.text          = "No invites yet"
            self.noDataLabel.textColor     = UIColor.gray
            self.noDataLabel.textAlignment = .center
            self.tableView.backgroundView  = self.noDataLabel
            self.tableView.separatorStyle  = .none
        }
    }
    func dataExist(){
        DispatchQueue.main.async {
            self.noDataLabel.isHidden = true
            self.tableView.separatorStyle  = .singleLine
        }
    }
    
    var invite = [Invites]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultValues = UserDefaults.standard
        let token = defaultValues.string(forKey: "token")
        let Auth_header    = ["Authorization" : token]
        showActivityIndicator()
        
        request("https://app.levler.co/api/v1/employe_invites", method: .get, parameters: nil , encoding: JSONEncoding.default, headers: (Auth_header as? HTTPHeaders)).validate().responseJSON { response in
            print("Invites sent: \(response.result)")
            self.hideActivityIndicator()
            
            switch response.result {
            case .success:
                
                // print(response.result.value as Any)
                let json: NSDictionary? = response.result.value as? NSDictionary
                if let jsonArray : NSArray = json!["data"] as? NSArray
                {
                    for element in jsonArray {
                        let jsonData = element as! NSDictionary
                        //getting user values
                        let name = jsonData.value(forKey: "name") as! String
                        let phone = jsonData.value(forKey: "phone") as! String
                        if let time = jsonData.value(forKey: "invite_time") as? String {
                            //print(time)
                            // let date = time.split(separator: " ", maxSplits: 2, omittingEmptySubsequences: true)
                            //let createDate = date[0]
                            
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                            if let date1 = dateFormatter.date(from:time){
                                //   print(date1)
                                let a = date1.getElapsedInterval()
                                // print(date1.getElapsedInterval())
                                
                                let inv = Invites(name: name, phone: phone, time: a)
                                self.invite.append(inv)
                            }
                        }
                        else{
                            let inv = Invites(name: name, phone: phone, time: "")
                            self.invite.append(inv)
                        }
                        //                self.invite.append(inv)
                    }
                    self.tableView.reloadData()
                }
                else
                {
                    self.noData()
                    // let data = "No invites"
                    
                    //  let inv = Invites(name: "", phone: data, time: "")
                    //  self.invite.append(inv)
                    
                }
                
                //self.tableView.reloadData()
                
            case .failure:
                print("error")
                self.noData()
                
            }
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return invite.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "inviteDetailCell", for: indexPath) as! SentDetailTableViewCell
        
        let invitesent = invite[indexPath.row]
        // cell.sno.text = String(indexPath.row + 1)
        self.dataExist()
        cell.name.text = invitesent.name
        cell.time.text = invitesent.time
        cell.contact.text = invitesent.phone
        
        return cell
    }  
}

