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
     var bringCashedData : Bool = false
     var cCode : String = ""
    
    
    func getCountryCode(cCode: String) -> String{
      
        return cCode
    }
    
    
    func downloadNews(completed: @escaping DownloadComplete) {
        print(cCode)
        var apiUrl : String = "https://newsapi.org/v2/top-headlines?country="
        apiUrl+=cCode
        apiUrl+="&apiKey=e3d93b527d044aa388a36c863ed6897c"
        print(apiUrl)
        
        if !Connectivity.isConnectedToInternet {
            print("no connection")
            self.getChasedNews()
            self.bringCashedData = true
            completed()
        }
        else {
            self.bringCashedData = false
            
        Alamofire.request(apiUrl).responseJSON { (response) in
  
            print(type(of: response.result.value))
            if let json = response.result.value as? [String:Any], // <- Swift Dictionary
                let results = json["articles"] as? [[String:Any]]  { // <- Swift Array
                
                for result in results {
                    let mtitle = result["title"] as? String ?? " "
                    let mauthor = result["author"] as? String ?? " "
                    let mdesc = result["description"] as? String ?? " "
                    let mimg = result["urlToImage"] as? String ?? " "
                    self.newsList.append(SingleNews(title: mtitle, author: mauthor, description: mdesc, imgUrl: mimg))
                }
            
            completed()
            
        }
            
            else {
                
                Alamofire.request(API_URL).responseJSON { (response) in
                    
                    print(type(of: response.result.value))
                    if let json = response.result.value as? [String:Any], // <- Swift Dictionary
                        let results = json["articles"] as? [[String:Any]]  { // <- Swift Array
                        
                        for result in results {
                            let mtitle = result["title"] as? String ?? " "
                            let mauthor = result["author"] as? String ?? " "
                            let mdesc = result["description"] as? String ?? " "
                            let mimg = result["urlToImage"] as? String ?? " "
                            self.newsList.append(SingleNews(title: mtitle, author: mauthor, description: mdesc, imgUrl: mimg))
                        }
                        
                        completed()
                        
                    }
                    
                }
                
            }
            
    }
            self.casheNews()
            
        }
        
        
    }
   
    
    

    func getChasedNews(){
        let appDelegate : AppDelegate = UIApplication.shared.delegate as!
        AppDelegate
        
        // 2
        let manageContext = appDelegate.persistentContainer.viewContext
        
        // 3
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CashedNews")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        // request.returnsObjectsAsFaults = false
        
        do {
            let result = try manageContext .fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "newsTitle") as! String)
                let mtitle = data.value(forKey: "newsTitle") as! String
                let mauthor = data.value(forKey: "newsAuthor") as! String
                let mdesc = data.value(forKey: "newsDesc") as! String
                let mimg = data.value(forKey: "newsImg") as! String
                    self.newsList.append(SingleNews(title: mtitle, author: mauthor, description: mdesc, imgUrl: mimg))
            }
            
            
        } catch {
            
            print("Failed")
        }
    }
    

    func casheNews(){
        for i in self.newsList.indices {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let context = appDelegate.persistentContainer.viewContext
            
            let entity = NSEntityDescription.entity(forEntityName: "CashedNews", in: context)
            let newEntity = NSManagedObject(entity: entity!, insertInto: context)
            
            
            newEntity.setValue(self.newsList[i].title, forKey: "newsTitle")
            newEntity.setValue(self.newsList[i].author, forKey: "newsAuthor")
            newEntity.setValue(self.newsList[i].imgUrl, forKey: "newsImg")
            newEntity.setValue(self.newsList[i].description, forKey: "newsDesc")
            
            do{
                // 5
                try context.save()
                
            }catch let error{
                
                print(error)
            }
            
          
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

