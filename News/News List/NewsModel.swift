//
//  NewsModel.swift
//  News
//
//  Created by Doaa Tantawy on 8/4/19.
//  Copyright © 2019 Doaa Tantawy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData

class NewsList {

     var newsList : [SingleNews] = []
    
    
    func downloadNews(completed: @escaping DownloadComplete) {
        if Connectivity.isConnectedToInternet {
            print("Yes! internet is available.")
        Alamofire.request(API_URL).responseJSON { (response) in
 
            print(response.result)
            if let json = response.result.value as? [String:Any], // <- Swift Dictionary
                let results = json["articles"] as? [[String:Any]]  { // <- Swift Array
                
                for result in results {
                    let mtitle = result["title"] as? String ?? " "
                    let mauthor = result["author"] as? String ?? " "
                    let mdesc = result["description"] as? String ?? " "
                    let mimg = result["urlToImage"] as? String ?? " "
                    self.newsList.append(SingleNews(title: mtitle, author: mauthor, description: mdesc, imgUrl: mimg))
                    
                    print(result["author"] as? String ?? " ")
                }
            
            completed()
            
        }
    }
        }
        
        else {
            print("no connection")
            completed()
        }
   
}
    
}


class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

struct SingleNews {
    var title: String
    var author: String
    var description: String
    var imgUrl: String
}

