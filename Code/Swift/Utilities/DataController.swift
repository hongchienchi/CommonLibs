//
//  DataController.swift
//  PW_Swift_HW
//
//  Created by CC Cooper on 7/1/16.
//  Copyright © 2016 CC Cooper. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class DataController
{

    static let sharedInstance = DataController()

    private init()
    {
        
    }
    
    func requestFeedData(endPoint: String, parameters:[String:String]?, completion:((feedArray : [Feed]?, error: NSError?) -> Void)?){

        let URL = "https://raw.githubusercontent.com/phunware/dev-interview-homework/master/feed.json"
        Alamofire.request(.GET, URL).responseArray { (response: Response<[Feed], NSError>) in
            
            let feedArray = response.result.value
            self.loadImage(feedArray!)
            
            if completion != nil {
                completion!(feedArray: feedArray!, error: nil)
                return
            }
        }
    }

    
    func loadImage(array:[Feed]?)
    {
        if array == nil || array!.count == 0 {
            return;
        }
        
        for feed:Feed in array! {
            
            guard let urlString = feed.imageURL else {
                continue
            }
            
            self.loadImage(urlString, completion:nil)
        }
    }

    
    
    func loadImage(urlString:String?, completion:((image:UIImage?, error:NSError?)->Void)?)
    {
        if urlString == nil || urlString!.characters.count == 0 {
            let error = NSError(domain: Constants.ErrorDomain, code:ErrorCode.invalidParams.rawValue, userInfo: nil)
            
            if completion != nil {
                completion!(image:nil, error:error);
                return
            }
        }
        
        if let image = ImagesCacheManager.sharedInstance.cache[urlString!] {
            
            if completion != nil {
                completion!(image: image, error: nil)
                return
            }
        }
        
        Alamofire.request(.GET, urlString!).validate().responseData { (response: Response<NSData, NSError>) in
            
            switch response.result {
                
            case .Success(let data):
                let image = UIImage(data: data)
                ImagesCacheManager.sharedInstance.cache[urlString!] = image
                
                if completion != nil {
                    completion!(image: image, error: nil)
                    return
                }
                
            case .Failure(let error):
                
                if completion != nil {
                    completion!(image:nil, error:error);
                    return
                }

                print("Request failed with error: \(error)")
            }
        }
        
        
        
        //        //Native way
        //        let imgURL: NSURL = NSURL(string: urlString)!
        //        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        //        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
        //
        //
        //            guard error == nil else{
        //                print("Error loading image: \(error?.description)")
        //                dispatch_async(dispatch_get_main_queue(), {
        //                    completion(image:nil, error:error);
        //                })
        //                return
        //            }
        //
        //            guard data != nil else{
        //                let myerror = NSError(domain: Constants.ErrorDomain, code:ErrorCode.noDataReturned.rawValue, userInfo: nil)
        //                dispatch_async(dispatch_get_main_queue(), {
        //                    completion(image:nil, error:myerror);
        //                })
        //                return
        //            }
        //
        //            let image = UIImage(data: data!)
        //            ImagesCacheManager.sharedInstance.cache[urlString] = image
        //            dispatch_async(dispatch_get_main_queue(), {
        //                completion(image: image, error: nil)
        //            })
        //
        //        }).resume()
        
        
        
        // This is deprecated
        //
        //        let mainQueue = NSOperationQueue.mainQueue()
        //
        //        NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) -> Void in
        //            if error == nil {
        //                // Convert the downloaded data in to a UIImage object
        //                let image = UIImage(data: data!)
        //                // Store the image in to our cache
        //                self.imageView.image = image
        //                
        //            }
        //            else {
        //                print("Error: \(error!.localizedDescription)")
        //            }
        //        })
    }
}


