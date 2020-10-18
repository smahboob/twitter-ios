//
//  NewTweetViewController.swift
//  Twitter
//
//  Created by Saad Mahboob on 17/10/2020.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController  {
    
    @IBOutlet weak var tweetText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetText.becomeFirstResponder()
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
        
    @IBAction func tweetButton(_ sender: Any) {
        if(!tweetText.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetText.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error here: \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        }
        else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
