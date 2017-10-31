//
//  HomeViewController.swift
//  Levler for Doctors
//
//  Created by Mohak on 14/10/17.
//  Copyright © 2017 Mohak. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate{
    
    
    @IBOutlet weak var mainView: UIView!
    // @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var overallratiinglabel: UILabel!
    @IBOutlet weak var totalreviewslabel: UILabel!
    
    @IBOutlet weak var goal_totalgoalLabel: UILabel!
    @IBOutlet weak var goal_description: UILabel!
    @IBOutlet weak var goal_finalLabel: UILabel!
    
    @IBOutlet weak var progress_tracklabel: UILabel!
    @IBOutlet weak var progress_catchuplabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var myProgress: UILabel!
    @IBOutlet weak var totalProgress: UILabel!
    
    //    @IBOutlet weak var overall_outoflocation: UILabel!
    
    //   @IBOutlet weak var total_outoflocation: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var location: UIStackView!
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var loadingView: UIView = UIView()
    
    @IBAction func menuButton(_ sender: Any) {
        menuViewDisplay()
    }
    func menuViewDisplay() {
        if(isOpen)
        {
            isOpen = false
            mainView.alpha = 1.0
            scrollView.isUserInteractionEnabled = true
            
            let viewMenuBack : UIView = view.subviews.last!
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                var frameMenu : CGRect = viewMenuBack.frame
                frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                viewMenuBack.frame = frameMenu
                viewMenuBack.layoutIfNeeded()
                viewMenuBack.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                viewMenuBack.removeFromSuperview()
                
            })
        }
        else if(!isOpen)
            
        {
            isOpen = true
            scrollView.isUserInteractionEnabled = false
            
            let menuVC : MenuViewController = self.storyboard!.instantiateViewController(withIdentifier: "menuViewController") as! MenuViewController
            self.view.addSubview(menuVC.view)
            self.addChildViewController(menuVC)
            menuVC.view.layoutIfNeeded()
            menuVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width-170, height: UIScreen.main.bounds.size.height);
                        
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                menuVC.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width-170, height: UIScreen.main.bounds.size.height);
            }, completion:nil)
            mainView.alpha = 0.3
            // scrollView.scrollToTop()
        }
        //    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        //  view.addGestureRecognizer(tap)
    }
    
    
    
    
    
    func doSomething() {
        menuViewDisplay()
        // change your view's frame here if you want
    }
    var isOpen = false
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        print(gesture.direction)
        let menuVC : MenuViewController = self.storyboard!.instantiateViewController(withIdentifier: "menuViewController") as! MenuViewController
        
        switch gesture.direction {
            /*case UISwipeGestureRecognizerDirection.down:
             print("down swipe")
             case UISwipeGestureRecognizerDirection.up:
             print("up swipe")*/
        case UISwipeGestureRecognizerDirection.left:
            // menuView.isHidden = true
            if(isOpen)
            {
                isOpen = false
                mainView.alpha = 1.0
                
                //     menuVC.view.removeFromSuperview()
                let viewMenuBack : UIView = view.subviews.last!
                
                UIView.animate(withDuration: 0.5, animations: { () -> Void in
                    var frameMenu : CGRect = viewMenuBack.frame
                    frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                    viewMenuBack.frame = frameMenu
                    viewMenuBack.layoutIfNeeded()
                    viewMenuBack.backgroundColor = UIColor.clear
                }, completion: { (finished) -> Void in
                    viewMenuBack.removeFromSuperview()
                    
                })
                scrollView.isUserInteractionEnabled = true
                
            }
            
            print("left swipe")
        case UISwipeGestureRecognizerDirection.right:
            //    menuView.isHidden = false
            if(!isOpen)
                
            {
                isOpen = true
                scrollView.isUserInteractionEnabled = false
                //  let menuVC : MenuViewController = self.storyboard!.instantiateViewController(withIdentifier: "menuViewController") as! MenuViewController
                self.view.addSubview(menuVC.view)
                self.addChildViewController(menuVC)
                menuVC.view.layoutIfNeeded()
                
                menuVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width-170, height: UIScreen.main.bounds.size.height);
                
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    menuVC.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width-170, height: UIScreen.main.bounds.size.height);
                }, completion:nil)

                mainView.alpha = 0.3
                //scrollView.scrollToTop()
            }
            print("right swipe")
            
        default:
            print("other swipe")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.isUserInteractionEnabled = true
        let directions: [UISwipeGestureRecognizerDirection] = [.right, .left]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(HomeViewController.handleSwipe(gesture:)))
            
            gesture.direction = direction
            self.view?.addGestureRecognizer(gesture)
        }
        let defaultValue = UserDefaults.standard
        
        self.myProgress.text = "0"
        let team_goal = defaultValue.string(forKey: "team_goal")
        // let total_review = defaultValues.string(forKey: "totalreview")
        let totalprogress = Int(team_goal!)
        self.totalProgress.text  = String(totalprogress!)
        self.goal_totalgoalLabel.text =  String(totalprogress!)
        self.goal_finalLabel.text = "\(totalprogress!) invites"
        self.progress_catchuplabel.text = " Send \(totalprogress!*2) invites to catchup"
        
        
        locationName()
        overallRating()
        totalReviews()
        // outOfLocations()
        //   progressBarDetails()
        allReviews()
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidDisappear(_ animated: Bool) {
        if isOpen
        {
            menuViewDisplay()
        }
        scrollView.isUserInteractionEnabled = true
    }
    
    
    //LOCATION
    func locationName()
    {
        let defaultValue = UserDefaults.standard
        let token = defaultValue.string(forKey: "token")
        let Auth_header    = ["Authorization" : token]
        
        request("https://app.levler.co/api/v1/current/location", method: .get, parameters: nil , encoding: JSONEncoding.default, headers: (Auth_header as? HTTPHeaders)).validate().responseJSON { response in
            print("Location: \(response.result)")
            
            switch response.result {
            case .success:
                let json = response.result.value as! NSDictionary
                let name = json["data"] as! String
                self.locationLabel.text = String(name)
                defaultValue.set(name, forKey: "location_name")
                
                
            case .failure:
                print("error")
            }
        }
    }
    
    //OVERALL RATING
    func overallRating(){
        let defaultValue = UserDefaults.standard
        let token = defaultValue.string(forKey: "token")
        let Auth_header    = ["Authorization" : token]
        
        request("https://app.levler.co/api/v1/over_all_rating", method: .get, parameters: nil , encoding: JSONEncoding.default, headers: (Auth_header as? HTTPHeaders)).validate().responseJSON { response in
            print("OverAll Rating: \(response.result)")
            
            switch response.result {
            case .success:
                let json = response.result.value as! [String: AnyObject]
                if let overallrate = json["data"] as? String
                {
                    self.overallratiinglabel.text = overallrate
                    
                }
                else{
                    self.overallratiinglabel.text = "0"
                    
                }
                
                
            case .failure:
                print("error")
            }
        }
    }
    //TOTAL REVIEWS
    func totalReviews()
    {
        let defaultValue = UserDefaults.standard
        let token = defaultValue.string(forKey: "token")
        let Auth_header    = ["Authorization" : token]
        
        request("https://app.levler.co/api/v1/reviews/total", method: .get, parameters: nil , encoding: JSONEncoding.default, headers: (Auth_header as? HTTPHeaders)).validate().responseJSON { response in
            print("Total Reviews: \(response.result)")
            
            switch response.result {
            case .success:
                if let json: NSDictionary = response.result.value as? NSDictionary{
                    if let totalreview = json["data"] as? Int {
                        self.totalreviewslabel.text = String(describing: totalreview)
                        self.myProgress.text = String(describing: totalreview)
                        //   defaultValue.set(totalreview, forKey: "totalreview")
                        
                        
                        let team_goal = defaultValue.string(forKey: "team_goal")
                        // let total_review = defaultValues.string(forKey: "totalreview")
                        let totalprogress = Double(team_goal!)
                        self.goal_totalgoalLabel.text =  String(Int32(totalprogress!))
                        // let my_progress = defaultValues.string(forKey: "invites_sent_count")
                        let myprogress = Double(totalreview)
                        
                        if (myprogress)>=(totalprogress)!
                        {
                            self.goal_description.text = "You have achieved your goal"
                            self.goal_finalLabel.text = "😍"
                            self.progress_tracklabel.text = "You're on track!"
                            self.progress_tracklabel.textColor = UIColor(red: 38/255, green: 183/255, blue: 91/255, alpha: 1.0)
                            
                            self.progress_catchuplabel.text = " Enjoy your achievement 🎖"
                        }
                        else
                        {
                            let recmd = Int(totalprogress! - myprogress)
                            self.goal_finalLabel.text = "\(recmd) invites"
                            self.progress_catchuplabel.text = " Send \(recmd*2) invites to catchup"
                        }
                        let progress: Double = Double(myprogress)/Double(totalprogress!)
                        print("PROGRESS % \(progress)")
                        
                        self.myProgress.text = String(Int(myprogress))
                        self.totalProgress.text = String(Int32(totalprogress!))
                        self.progressBar.progress = Float(progress)
                        self.progressBar.setProgress(Float(progress), animated: true)
                    }
                    else {
                        /* self.myProgress.text = "0"
                         let team_goal = defaultValue.string(forKey: "team_goal")
                         // let total_review = defaultValues.string(forKey: "totalreview")
                         let totalprogress = Int(team_goal!)
                         self.goal_totalgoalLabel.text =  String(totalprogress!)
                         self.goal_finalLabel.text = "\(totalprogress!) invites"
                         self.progress_catchuplabel.text = " Send \(totalprogress!*2) invites to catchup"*/
                    }
                    
                }
                else {
                    /*
                     self.myProgress.text = "0"
                     let team_goal = defaultValue.string(forKey: "team_goal")
                     // let total_review = defaultValues.string(forKey: "totalreview")
                     let totalprogress = Int(team_goal!)
                     self.goal_totalgoalLabel.text =  String(totalprogress!)
                     self.goal_finalLabel.text = "\(totalprogress!) invites"
                     self.progress_catchuplabel.text = " Send \(totalprogress!*2) invites to catchup"
                     */
                    
                }
                
            case .failure:
                print("error")
            }
        }
    }
    
    
 
    //SPINNER
    func showActivityIndicator() {
        
        DispatchQueue.main.async {
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            self.loadingView.center = self.tableView.center
            self.loadingView.backgroundColor = UIColor.lightGray
            self.loadingView.alpha = 0.7
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10
            
            self.spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)
            
            self.loadingView.addSubview(self.spinner)
            self.tableView.addSubview(self.loadingView)
            self.spinner.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }
     
    
    
    //NO DATA FOUND
    let noDataLabel: UILabel  = UILabel()
    
    func noData(){
        DispatchQueue.main.async {
            self.noDataLabel.frame  = CGRect(x: 0.0, y: 0.0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height)
            self.noDataLabel.text          = "No reviews yet"
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
    //ALL REVIEWS
    func allReviews()
    {
        let defaultValue = UserDefaults.standard
        let token = defaultValue.string(forKey: "token")
        let Auth_header    = ["Authorization" : token]
        showActivityIndicator()
        
        request("https://app.levler.co/api/v1/employe/google_reviews", method: .post, parameters: nil , encoding: JSONEncoding.default, headers: (Auth_header as? HTTPHeaders)).validate().responseJSON { response in
            print("All reviews - Google: \(response.result)")
            self.hideActivityIndicator()
            
            switch response.result {
            case .success:
                
                //print(response.result.value as Any)
                if let json: NSDictionary = response.result.value as? NSDictionary
                {
                    if let jsonArray:NSArray = (json["message"] as? NSArray)
                    {
                        if jsonArray.count > 5
                        {
                            print("5")
                            for element in jsonArray.prefix(5) {
                                let jsonData = element as! NSDictionary
                                //getting user values
                                let name = jsonData.value(forKey: "name") as! String
                                let rating = jsonData.value(forKey: "rating") as! Int
                                let des: String? = jsonData.value(forKey: "comment") as? String
                                let src = jsonData.value(forKey: "src") as! String
                                let img = UIImage(named: "001-search")!
                                let reviews = TotalReview(name: name, rating: rating, imageURL: NSURL(string:src)!, image: img,  description:des)
                                self.treview.append(reviews)
                                self.tableView.reloadData()
                                
                            }
                        }
                            
                        else
                        {
                            print("not 5")
                            for element in jsonArray {
                                
                                let jsonData = element as! NSDictionary
                                //getting user values
                                let name = jsonData.value(forKey: "name") as! String
                                let rating = jsonData.value(forKey: "rating") as! Int
                                let des: String? = jsonData.value(forKey: "comment") as? String
                                let src = jsonData.value(forKey: "src") as! String
                                let img = UIImage(named: "001-search")!
                                
                                let reviews = TotalReview(name: name, rating: rating, imageURL: NSURL(string:src)!,image: img, description:des)
                                self.treview.append(reviews)
                                print("google")
                                self.tableView.reloadData()
                                
                            }
                            self.showActivityIndicator()
                            
                            request("https://app.levler.co/api/v1/employe/facebook_reviews", method: .get, parameters: nil , encoding: JSONEncoding.default, headers: (Auth_header as? HTTPHeaders)).responseJSON { response1 in
                                print("All reviews - Fb reviews: \(response1.result)")
                                self.hideActivityIndicator()
                                
                                print(5-jsonArray.count)
                                //print(response.result.value as Any)
                                if let json1: NSDictionary = response1.result.value as? NSDictionary
                                {
                                    
                                    if let jsonArray1 : NSArray = json1["message"] as? NSArray
                                    {
                                        for element1 in (jsonArray1.prefix(5-jsonArray.count)) {
                                            let jsonData1 = element1 as! NSDictionary
                                            //getting user values
                                            let name = jsonData1.value(forKey: "name") as! String
                                            let rating = jsonData1.value(forKey: "rating") as! Int
                                            let des: String? = jsonData1.value(forKey: "comment") as? String
                                            let src = jsonData1.value(forKey: "src") as! String
                                            let img = UIImage(named: "003-facebook")!
                                            
                                            let reviews = TotalReview(name: name, rating: rating, imageURL: NSURL(string:src)!,image: img , description:des)
                                            self.treview.append(reviews)
                                            print(reviews)
                                            print("fb")
                                            self.tableView.reloadData()
                                        }
                                    }
                                    else if (json1["message"] as? String) != nil
                                    {
                                        print("1")
                                        self.noData()
                                    }
                                    else if (json["message"]) == nil{
                                        print("1.2")
                                        self.noData()
                                    }
                                }
                                else
                                {
                                    print("2")
                                    self.noData()
                                }
                            }
                        }
                        self.tableView.reloadData()
                    }
                    else
                    {
                        
                        print("3")
                        // self.noData()
                        self.showActivityIndicator()
                        
                        request("https://app.levler.co/api/v1/employe/facebook_reviews", method: .get, parameters: nil , encoding: JSONEncoding.default, headers: (Auth_header as? HTTPHeaders)).responseJSON { response1 in
                            print("All reviews - not google, only Fb reviews: \(response1.result)")
                            self.hideActivityIndicator()
                            switch response1.result {
                            case .success:
                                
                                //print(response.result.value as Any)
                                if let json: NSDictionary = response1.result.value as? NSDictionary
                                {
                                    if let jsonArray:NSArray = (json["message"] as? NSArray)
                                    {
                                        for element in jsonArray.prefix(5) {
                                            let jsonData = element as! NSDictionary
                                            //getting user values
                                            let name = jsonData.value(forKey: "name") as! String
                                            let rating = jsonData.value(forKey: "rating") as! Int
                                            let des: String? = jsonData.value(forKey: "comment") as? String
                                            let src = jsonData.value(forKey: "src") as! String
                                            let img = UIImage(named: "003-facebook")!
                                            let reviews = TotalReview(name: name, rating: rating, imageURL: NSURL(string:src)!, image: img,  description:des)
                                            self.treview.append(reviews)
                                            self.tableView.reloadData()
                                        }
                                        self.tableView.reloadData()
                                    }
                                    else if (json["message"] as? String) != nil{
                                        print("5.1")
                                        self.noData()
                                    }
                                    else if (json["message"]) == nil{
                                        print("6.1")
                                        self.noData()
                                    }
                                }
                                else
                                {
                                    print("7.1")
                                    self.noData()
                                }
                            case .failure:
                                print("error")
                                self.noData()
                            }
                            
                        }
                        
                    }
                }
                else{
                    print("4")
                    self.noData()
                }
                
            case .failure:
                //self.noData()
                self.showActivityIndicator()
                
                request("https://app.levler.co/api/v1/employe/facebook_reviews", method: .get, parameters: nil , encoding: JSONEncoding.default, headers: (Auth_header as? HTTPHeaders)).responseJSON { response1 in
                    print("All reviews - only Fb reviews: \(response1.result)")
                    self.hideActivityIndicator()
                    switch response1.result {
                    case .success:
                        
                        //print(response.result.value as Any)
                        if let json: NSDictionary = response1.result.value as? NSDictionary
                        {
                            if let jsonArray:NSArray = (json["message"] as? NSArray)
                            {
                                for element in jsonArray.prefix(5) {
                                    let jsonData = element as! NSDictionary
                                    //getting user values
                                    let name = jsonData.value(forKey: "name") as! String
                                    let rating = jsonData.value(forKey: "rating") as! Int
                                    let des: String? = jsonData.value(forKey: "comment") as? String
                                    let src = jsonData.value(forKey: "src") as! String
                                    let img = UIImage(named: "003-facebook")!
                                    let reviews = TotalReview(name: name, rating: rating, imageURL: NSURL(string:src)!, image: img,  description:des)
                                    self.treview.append(reviews)
                                    self.tableView.reloadData()
                                }
                                self.tableView.reloadData()
                            }
                            else if (json["message"] as? String) != nil{
                                print("5")
                                self.noData()
                            }
                            else if (json["message"]) == nil{
                                print("6")
                                self.noData()
                            }
                        }
                        else
                        {
                            print("7")
                            self.noData()
                        }
                    case .failure:
                        print("error")
                        self.noData()
                    }
                    
                }
            }
        }
    }
    
    struct TotalReview {
        let name : String
        let rating : Int
        let imageURL : NSURL
        let image : UIImage
        let description : String?
    }
    var rate = ["✩","✩","✩","✩","✩"]
    var treview = [TotalReview]()
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        
    {
        return treview.count
    }
    public func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    var a = 0.0
    var x = 0.0
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeReivewTableViewCell
        let reviews = treview[indexPath.row]
        
        
        var rates: [String] = rate
        for i in 0...(reviews.rating-1)
        {
            rates[i] = "★"
        }
        let rateArray = rates.flatMap { String.CharacterView($0) }
        
        let rateString = String(rateArray)
       
        //dataExist()
        cell.reviewimage.image = reviews.image
        cell.reviewname.text = reviews.name
        cell.reviewrate.text = rateString
        cell.reviewDes.text = reviews.description
        cell.reviewDes.sizeToFit()
        
        a = Double(cell.reviewDes.frame.height)
        
        x = 120 + a
        
        
       
        
        return cell
    }
    func tableView(_ tableView: UITableView,heightForRowAt indexPath:IndexPath) -> CGFloat
    {
        
        return CGFloat(x)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 300
    }
    
}
