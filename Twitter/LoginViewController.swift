//
//  LoginViewController.swift
//  Twitter
//
//  Created by Saad Mahboob on 10/10/2020.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButtonOutlet.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let loggedIn = UserDefaults.standard.bool(forKey: "loggedIn")
        
        if(loggedIn == true){
            self.performSegue(withIdentifier: "proceedToHome", sender: self)
        }
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        let myURL = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: myURL, success: {
            
            //to remember if logged in dont displya login button at start
            UserDefaults.standard.set(true, forKey: "loggedIn")
            
            self.performSegue(withIdentifier: "proceedToHome", sender: self)
        }, failure: { (Error) in
            print("Error while logging in")
        })
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
