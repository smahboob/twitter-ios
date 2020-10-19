//
//  TweetCell.swift
//  Twitter
//
//  Created by Saad Mahboob on 11/10/2020.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    var favorited:Bool =  false
    var tweetId: Int = -1
    var retweeted:Bool = false
    
    func setLike(_ isFavorited:Bool){
        favorited = isFavorited
        if(favorited){
            likeButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        }
        else{
            likeButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    
    
    @IBAction func likeTheTweet(_ sender: Any) {
        
        let toBeFavorited = !favorited
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setLike(true)
            }, failure: { (error) in
                print("Issue in favoriting a tweet")
            })
        }
        else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setLike(false)
            }, failure: { (error) in
                print("unfav tweet issue")
            })
        }
        
    }
    
    func setRetweeted(_ isRetweeted:Bool){
        retweeted = isRetweeted
        if(retweeted){
            retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
//            retweetButton.isEnabled = false
        }
        else{
            retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
//            retweetButton.isEnabled = true
        }
    }
    
    @IBAction func retweetAction(_ sender: Any) {
        let toBeRetweeted = !retweeted
        if (toBeRetweeted) {
            TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
                self.setRetweeted(true)
            }, failure: { (error) in
                print("retweet failed")
            })
        }
        else{
            TwitterAPICaller.client?.unRetweet(tweetId: tweetId, success: {
                self.setRetweeted(false)
            }, failure: { (error) in
                print("unretweet issue")
            })
        }
        
    }
    
    
    //not yet implemented
    @IBAction func replyAction(_ sender: Any) {
    }
    
}
