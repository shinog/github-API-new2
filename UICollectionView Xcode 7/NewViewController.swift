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

class NewViewController: UIViewController
{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelView: UILabel!
    
    var image = UIImage()
    var avatar_link:String?
    var type_link:String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        labelView.text = self.type_link
        imageView.sd_setImageWithURL(NSURL(string: avatar_link!))

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
