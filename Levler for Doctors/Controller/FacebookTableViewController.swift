//
//  FacebookTableViewController.swift
//  Levler for Doctors
//
//  Created by Mohak on 14/10/17.
//  Copyright © 2017 Mohak. All rights reserved.
//

import UIKit
import Alamofire

class FacebookTableViewController: UITableViewController {
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var loadingView: UIView = UIView()
    
    struct Fbreview {
        let name : String
        let rating : Int
        // let imageURL : NSURL
        let description : String?
    }
    var a = 0.0
    var x = 0.0
    
    let rate2 = ["✩","✩","✩","✩","✩"]
    let img2 = UIImage(named: "003-facebook")!
    
    
    
    var fbreview = [Fbreview]()
    
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
            self.noDataLabel.text          = "No facebook reviews yet"
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaultValues = UserDefaults.standard
        let token = defaultValues.string(forKey: "token")
        let Auth_header    = ["Authorization" : token]
        showActivityIndicator()
        
        request("https://app.levler.co/api/v1/employe/facebook_reviews", method: .get, parameters: nil , encoding: JSONEncoding.default, headers: (Auth_header as? HTTPHeaders)).validate().responseJSON { response in
            print("Facebook reviews: \(response.result)")
            self.hideActivityIndicator()
            
            switch response.result {
            case .success:
                // print(response.result.value as Any)
                let json: NSDictionary? = response.result.value as? NSDictionary
                if let jsonArray : NSArray = json!["message"] as? NSArray{
                    // print(jsonArray)
                    for element in jsonArray {
                        let jsonData = element as! NSDictionary
                        //getting user values
                        let name = jsonData.value(forKey: "name") as! String
                        let rating = jsonData.value(forKey: "rating") as! Int
                        let des: String? = jsonData.value(forKey: "comment") as? String
                        // let src = jsonData.value(forKey: "src") as! String
                        let review = Fbreview(name: name, rating: rating, description:des)
                        self.fbreview.append(review)
                        self.tableView.reloadData()
                        
                    }
                    self.tableView.reloadData()
                }
                else {
                    self.noData()
                }
                
            //switching the screen
            case .failure:
                self.noData()
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        //   tableView.delegate = self
        //   tableView.dataSource = self
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        
    {
        return fbreview.count
    }
    
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "fbreviewcell", for: indexPath) as! FacebookReviewTableViewCell
        let review = fbreview[indexPath.row]
        
        //rating
        var rates: [String] = rate2
        for i in 0...(review.rating-1)
        {
            rates[i] = "★"
        }
        let rateArray = rates.flatMap { String.CharacterView($0) }
        
        let rateString = String(rateArray)
        
        dataExist()
        cell.fimg?.image = img2
        cell.fname?.text = review.name
        cell.frate?.text = rateString
        cell.fdes?.text = review.description
        cell.fdes.sizeToFit()
        if (cell.fname.text == "No facebook reviews yet")
        {
            cell.fimg.isHidden = true
            cell.frate.isHidden = true
            cell.fname.textColor = UIColor.lightGray
            cell.fname.textAlignment = NSTextAlignment.left
            
        }
        //  cell.readmore.isHidden = true
        
        a = Double(cell.fdes.frame.height)
        
        x = 120 + a
        
        
        return cell
        
    }
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView,heightForRowAt indexPath:IndexPath) -> CGFloat
    {
        
        return CGFloat(x)
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 140
    }
    
}

