//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Saad Mahboob on 11/10/2020.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var tweetsArray = [NSDictionary]()
    var numberOfTweets: Int!
    let myRefresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
        
        //pull down to load tweets again
        myRefresh.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myRefresh
    }
    
    //load tweets again after u return from tweeting
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadTweets()
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        UserDefaults.standard.setValue(false, forKey: "loggedIn")
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func loadTweets(){
        
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweets = 20
        let tweetParams = ["count":numberOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: tweetParams as [String : Any], success:
            { (tweets: [NSDictionary]) in
            
                self.tweetsArray.removeAll()
                for tweet in tweets{
                    self.tweetsArray.append(tweet)
                }
                
                self.tableView.reloadData()
                self.myRefresh.endRefreshing()
            
            }, failure: { (Error) in
                print("We have an error in loading tweets.")
            })
    }
    
    
    func loadInfiniteTweets(){
        
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweets = numberOfTweets + 20
        let tweetParams = ["count":numberOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: tweetParams as [String : Any], success:
            { (tweets: [NSDictionary]) in
            
                self.tweetsArray.removeAll()
                for tweet in tweets{
                    self.tweetsArray.append(tweet)
                }
                
                self.tableView.reloadData()
            
            }, failure: { (Error) in
                print("We have an error in loading tweets.")
            })
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetsArray.count {
            loadInfiniteTweets()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = tweetsArray[indexPath.row]["user"] as! NSDictionary
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        let date = (user["created_at"] as! String)
        let range = date.index(date.startIndex, offsetBy: 0)..<date.index(date.endIndex, offsetBy: -19)
        
        let finalDate = date[range]
        var dateString = ""
        dateString.append(contentsOf: finalDate)
        
        cell.tweetContent.text = (tweetsArray[indexPath.row]["text"] as! String)
        cell.userName.text = (user["name"] as! String)
        cell.dateLabel.text = dateString
        
        let imageURL = URL(string: (user["profile_image_url_https"] as! String))
        let data = try? Data(contentsOf: imageURL!)
        
        if let imageData = data {
            cell.profileImage.image = UIImage(data: imageData)
        }
        
        return cell
    }

}
