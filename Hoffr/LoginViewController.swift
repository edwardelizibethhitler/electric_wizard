//
//  ViewController.swift
//  Hoffr
//
//  Created by admin on 08/12/2015.
//  Copyright © 2015 admin. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    @IBOutlet weak var dontLoginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let user = User.theUser //declare theUser object to store user data
        
        if(FBSDKAccessToken.currentAccessToken() == nil){
            print("User is not logged in")
            user.works()
        }
        else{
            let tabBar = (self.storyboard?.instantiateViewControllerWithIdentifier("TabBarController"))! as! UITabBarController
            self.presentViewController(tabBar, animated: true, completion: nil)
        }
        
        loginButton.delegate = self
        loginButton.readPermissions = ["public_profile","email"] //request the permissions we will use
    }
    
    /*!
    @abstract Sent to the delegate when the button was used to login.
    @param loginButton the sender
    @param result The results of the login
    @param error The error (if any) from the login
    */
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!){}
    
    /*!
    @abstract Sent to the delegate when the button was used to logout.
    @param loginButton The button that was clicked.
    */
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!){
        
    }
    
    //takes us to the search page
    @IBAction func dontLoginButton(sender: UIButton) {
        //let searchPage = self.storyboard?.instantiateViewControllerWithIdentifier("SearchPageViewController") as! SearchPageViewController
        let tabBar = (self.storyboard?.instantiateViewControllerWithIdentifier("TabBarController"))! as! UITabBarController
        //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //appDelegate.window?.rootViewController = searchPageNav
        //searchPageNav.viewDidLoad()
        //searchPageNav.viewDidLoad()
        self.presentViewController(tabBar, animated: true, completion: nil)
        //self.performSegueWithIdentifier("GoToTabBar", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

