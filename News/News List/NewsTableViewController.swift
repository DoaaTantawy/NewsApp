//
//  NewsTableViewController.swift
//  News
//
//  Created by Doaa Tantawy on 8/4/19.
//  Copyright © 2019 Doaa Tantawy. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher
import Alamofire

class HeadlinesCellView: UITableViewCell{
    
    @IBOutlet weak var newsImg: UIImageView!
    
    @IBOutlet weak var newsTitle: UILabel!
    
    @IBOutlet weak var newsAuthor: UILabel!
    
    @IBOutlet weak var newsDescription: UILabel!
    
}

class NewsTableViewController: UITableViewController {
    var news:NewsList!
    var countryCodeUrl : String = "us"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.countryCodeUrl)
        
        self.refreshControl?.addTarget(self, action:
            #selector(self.refreshNews(sender:)), for: UIControl.Event.valueChanged)
        //self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableView.automaticDimension
        
        news = NewsList()
        news.cCode = news.getCountryCode(cCode: countryCodeUrl)
        news.downloadNews {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
      

    }
    
  

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if news.bringCashedData {
            return 5
        }
        else {
        return news.newsList.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HeadlinesCellView

        // Configure the cell...
        
        
        let url = URL(string: news.newsList[indexPath.row].imgUrl)
        cell.newsImg?.kf.setImage(with: url)
        cell.newsAuthor?.text = news.newsList[indexPath.row].author
        cell.newsTitle?.text = news.newsList[indexPath.row].title
        cell.newsDescription?.text = news.newsList[indexPath.row].description
        
        

        return cell
    }
 
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(150)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let desc = news.newsList[indexPath.row].description
        self.viewDesc(newsDesc: desc)
    }
    

    func viewDesc(newsDesc : String) {
        
        let alert = UIAlertController(title: "Description",
                                      message: newsDesc,
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }

 
    @objc func refreshNews(sender:AnyObject) {
        self.news.downloadNews {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print("Reloaded")
            }
            
        }
        self.refreshControl?.endRefreshing()
    }

}
