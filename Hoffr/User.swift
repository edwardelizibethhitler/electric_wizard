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
    
    
    static let theUser = User() //init the singleton
    
    //initialise userID to 0 - means no user logged in
    private init(){
        userID = 0
    }
    
    func setUserID(id: Int){
        userID = id
    }
    
    func works(){
        print("it works")
    }
}
