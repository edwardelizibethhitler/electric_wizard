//
//  User.swift
//  Hoffr
//
//  Created by admin on 14/12/2015.
//  Copyright © 2015 admin. All rights reserved.
//

//singleton User class used to store the logged in users data

import Foundation

class User {
    
    private var userID: Int
    private var locationEnabled: Bool = false //does the user want to use locaation services
    
    static let theUser = User() //init the singleton
    
    //initialise userID to 0 - means no user logged in
    private init(){
        userID = 0
    }
    
    func setUserID(id: Int){
        userID = id
    }
    
    func enableLocation(){
        locationEnabled = true
    }
    
    func disableLocation(){
        locationEnabled = false
    }
    
    func works(){
        print("it works")
    }
}
