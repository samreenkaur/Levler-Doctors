//
//  GoogleTableViewController.swift
//  Levler for Doctors
//
//  Created by Mohak on 15/10/17.
//  Copyright © 2017 Mohak. All rights reserved.
//

import UIKit
import Alamofire

class GoogleTableViewController: UITableViewController {
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var loadingView: UIView = UIView()
    
    struct Goreview {
        let name : String
        let rating : Int
        // let imageURL : NSURL
        let description : String?
    }
    
    var rate1 = ["✩","✩","✩","✩","✩"]
    let img1 = UIImage(named: "001-search")!
    var a = 0.0
    var x = 0.0
    var goreview = [Goreview]()
    
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
            self.noDataLabel.text          = "No google reviews yet"
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
        request("https://app.levler.co/api/v1/employe/google_reviews", method: .post, parameters: nil , encoding: JSONEncoding.default, headers: (Auth_header as? HTTPHeaders)).validate().responseJSON { response in
            print("Google reviews: \(response.result)")
            self.hideActivityIndicator()
            
            switch response.result {
            case .success:
                
                // print(response.result.value as Any)
                let json: NSDictionary? = response.result.value as? NSDictionary
                if let jsonArray: NSArray = json!["message"] as? NSArray {
                    for element in jsonArray {
                        let jsonData = element as! NSDictionary
                        //getting user values
                        let name = jsonData.value(forKey: "name") as! String
                        let rating = jsonData.value(forKey: "rating") as! Int
                        let des: String? = jsonData.value(forKey: "comment") as? String
                        // let src = jsonData.value(forKey: "src") as! String
                        let review = Goreview(name: name, rating: rating,  description:des)
                        self.goreview.append(review)
                        self.tableView.reloadData()
                        
                        /* print("name: \(name)")
                         print("rating: \(rating)")
                         print("Description: \(des)")
                         */
                    }
                    self.tableView.reloadData()
                    
                }
                else{
                    self.noData()
                }
                
                
            case .failure:
                self.noData()
            }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        
    {
        return goreview.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "googlereviewcell", for: indexPath) as! GoogleReviewTableViewCell
        let review = goreview[indexPath.row]
        //rating
        var rates: [String] = rate1
        for i in 0...(review.rating-1)
        {
            rates[i] = "★"
        }
        let rateArray = rates.flatMap { String.CharacterView($0) }
        
        let rateString = String(rateArray)
        //print(rateString)
        
        dataExist()
        cell.gimg?.image = img1
        cell.gname?.text = review.name
        cell.grate?.text = rateString
        cell.gdes?.text = review.description
        cell.gdes.sizeToFit()
        
        a = Double(cell.gdes.frame.height)
        //  cell.readmore.isHidden = true
        
        x = 120 + a
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView,heightForRowAt indexPath:IndexPath) -> CGFloat
    {
        
        return CGFloat(x)
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 140
    }
    // MARK: - Table view data source
    
    
    
    
}


