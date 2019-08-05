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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableView.automaticDimension
        
        news = NewsList()
        news.downloadNews {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print("hello")
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
        return news.newsList.count
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
