//
//  ViewController.swift
//  UICollectionView Xcode 7
//
//  Created by PJ Vea on 7/1/15.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    @IBOutlet weak var collectionView: UICollectionView!
    
    let appleProducts = ["豆乳パスタ", "塩味パスタ", "クリームうどん", "豆乳坦々そうめん"]
    let imageArray = [UIImage(named: "dely1"), UIImage(named: "dely2"), UIImage(named: "dely3"), UIImage(named: "dely4"), UIImage(named: "dely1"), UIImage(named: "dely2"), UIImage(named: "dely3"), UIImage(named: "dely4"), UIImage(named: "dely1"), UIImage(named: "dely2"), UIImage(named: "dely3"), UIImage(named: "dely4"), UIImage(named: "dely1"), UIImage(named: "dely2"), UIImage(named: "dely3"), UIImage(named: "dely4"), UIImage(named: "dely1"), UIImage(named: "dely2"), UIImage(named: "dely3"), UIImage(named: "dely4"), UIImage(named: "dely1"), UIImage(named: "dely2"), UIImage(named: "dely3"), UIImage(named: "dely4"), UIImage(named: "dely1"), UIImage(named: "dely2"), UIImage(named: "dely3"), UIImage(named: "dely4"), UIImage(named: "dely1"), UIImage(named: "dely2")]
    let urllink = ["1cd2992a-d133-4ead-9960-8dc82027f51a", "e8d49666-fa98-45fb-b177-9d0f1244be31", "7278403c-24b2-4854-890e-5fe5cc735aee", "8e21512f-9003-4bb0-9f8a-fc74a3af0d52"]
    
    var articles: [[String: String?]] = []
    let github_url = "https://api.github.com/users";
    var avatar_link: String = ""

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getArticles()
    }
    
    
    func getArticles() {
        Alamofire.request(.GET, github_url)
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                
                let json = JSON(object)
                json.forEach { (_, json) in
                    let article: [String: String?] = [
                        "avatar": json["avatar_url"].string,
                        "name": json["login"].string,
                        "type": json["type"].string
                    ]
                    self.articles.append(article)
                }
                self.collectionView.reloadData()
        }
    }



    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return articles.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        let article = articles[indexPath.row]
        
        cell.imageView?.image = self.imageArray[indexPath.row]
        cell.titleLabel?.text = article["name"]!
                
        return cell
    }

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        self.performSegueWithIdentifier("showImage", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "showImage"
        {
            
            let indexPaths = self.collectionView!.indexPathsForSelectedItems()!
            let indexPath = indexPaths[0] as NSIndexPath
            
            let article = articles[indexPath.row]
            
            let vc = segue.destinationViewController as! NewViewController
            
            vc.title = article["name"]!
            vc.avatar_link = article["avatar"]!
            vc.type_link = article["type"]!
        }
    }
    
    //追加分
    
}

