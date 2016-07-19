//
//  NewViewController.swift
//  UICollectionView Xcode 7
//
//  Created by PJ Vea on 7/1/15.
//  Copyright © 2015 Vea Software. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Firebase
import FirebaseDatabase

class NewViewController: UIViewController
{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var buttonView: UIButton!
    
    
    var image = UIImage()
    var avatar_link:String?
    var type_link:String?
    var senderId:String?
    
    // var messages: [String:String]
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        senderId = "1234"
        
        let ref = FIRDatabase.database().reference()
        ref.observeEventType(.Value, withBlock: { snapshot in
            guard let dic = snapshot.value as? Dictionary<String, AnyObject> else {
                return
            }
            guard let posts = dic["favorites"] as? Dictionary<String, Dictionary<String, String>> else {
                return
            }
            
            //self.messages = posts.values.map { dic in  //エラー
            //    let senderId = dic["senderId"]
            //    let item = dic["item"]
            //    return(senderId: senderId,  item: item)
            //}
            self.buttonView.layer.cornerRadius = 10
            if posts["-KN0V_T5bnlyBEHo1TPc"]!["senderId"] == self.senderId {
                self.buttonView.setTitle("お気に入り済み", forState: .Normal)
                self.buttonView.backgroundColor = UIColor.grayColor()
            } else {
                self.buttonView.setTitle("お気に入り", forState: .Normal)
                self.buttonView.backgroundColor = UIColor.orangeColor()
            }
        })
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        labelView.text = self.type_link
        imageView.sd_setImageWithURL(NSURL(string: avatar_link!))
        
    }

    @IBAction func addFavorite(sender: AnyObject) {
        let ref = FIRDatabase.database().reference()
        ref.observeEventType(.Value, withBlock: { snapshot in
            guard let dic = snapshot.value as? Dictionary<String, AnyObject> else {
                return
            }
            guard let posts = dic["favorites"] as? Dictionary<String, Dictionary<String, String>> else {
                return
            }
            self.buttonView.layer.cornerRadius = 10
            if posts["-KN0V_T5bnlyBEHo1TPc"]!["senderId"] == self.senderId {
                //ref.child("favorites").childByAutoId().removeValue()  //機能しない
                self.buttonView.setTitle("お気に入り", forState: .Normal)
                self.buttonView.backgroundColor = UIColor.orangeColor()
            } else {
                //ref.child("favorites").childByAutoId().setValue(
                //    ["senderId": self.senderId!, "item": self.avatar_link!])  //永遠とデータを格納し続けてしまう
                self.buttonView.setTitle("お気に入り済み", forState: .Normal)
                self.buttonView.backgroundColor = UIColor.grayColor()
            }
        })
        
    }
    
    override func didReceiveMemoryWarning()
    {
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
