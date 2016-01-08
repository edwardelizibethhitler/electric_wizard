//
//  APIManager.swift
//  Hoffr
//
//  Created by admin on 31/12/2015.
//  Copyright © 2015 admin. All rights reserved.
//

//class handles requests to the server api/search engine

import UIKit

class APIManager: NSObject {

    static let sharedInstance = APIManager() //make singleton
    
    //function makes query to server based on query string provided - completion handler deals with JSON results
    func get_JSON(query: String, completion: ((result: NSDictionary) -> Void)){
        let baseURL = "http://52.30.77.26/"
        let query = query
        
        if let url = NSURL(string: baseURL + query){
            NSURLSession.sharedSession().dataTaskWithURL(url){data, respnose, error in
                
                if(data != nil){
                    do{
                        let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)[0] as! NSDictionary
                        dispatch_async(dispatch_get_main_queue()){
                            completion(result:json)
                        }
                        
                    }catch let error as JSONError {
                        print(error.rawValue)
                    } catch {
                        print(error)
    
                    }
                    
                }
                
            }.resume()
        }
    }
    
    //function gets image from server - query string must have form "property_$id/photo_$id"
    func get_image(query: String, completion: ((image: UIImage?) -> Void)){
        let baseURL = "http://52.30.77.26/uploads/property_photo/"
    
        if let url = NSURL(string: baseURL + query){
            NSURLSession.sharedSession().dataTaskWithURL(url){data,response, error in
                if (data != nil) {
                    let image = UIImage(data: data!)
                    dispatch_async(dispatch_get_main_queue()){
                        completion(image: image)
                    }
                }
            }.resume()
        }
    
    }
    
    //custom error message to find out at what point in JSON getting process cockup occurs
    enum JSONError: String, ErrorType {
        case NoData = "Error: no data"
        case ConversionFailed = "Error: conversion from JSON failed"
    }
    
    //json parser  --- DONT THINK I NEED THIS ANYMORE PROBABLY REMOVE IT
    func jsonParser(url: String ,completionHandler: (NSData?, NSError?) -> NSDictionary?) -> NSURLSessionTask?{
        
        let urlPath = url
        
        guard let endpoint = NSURL(string: urlPath) else {print("Error creating endpoint"); return nil}
        let request = NSMutableURLRequest(URL: endpoint)
        //var back: NSDictionary?
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
            
            dispatch_async(dispatch_get_main_queue()){
              completionHandler(data, error)
            }
            }
        task.resume()
        return task
    }
    
    
}
