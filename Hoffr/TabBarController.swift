//
//  TabBarController.swift
//  Hoffr
//
//  Created by admin on 28/12/2015.
//  Copyright © 2015 admin. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    private var first_time: Bool = false
    
    /*override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print(first_time)
        if(!first_time){
            first_time = true
            let login = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
            self.presentViewController(login, animated: false, completion: nil)
        }
        print(first_time)
    }*/

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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
