//
//  DataTableViewCell.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/8/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit

protocol ImageDownloadDelegate {
    func imageDownloaded(image:UIImage , indexPath:IndexPath)
}

struct DataTableViewCellData {

    //init(imageUrl: String, text: String , vidobj: VideoObject )
    init(imageUrl: String, text: String)
    {
        self.imageUrl = imageUrl
        self.text = text
      //  vidObj = vidobj
    }
    var imageUrl: String
    var text: String
    //var vidObj  = VideoObject()
}

class DataTableViewCell : BaseTableViewCell  {
    
    @IBOutlet weak var dataImage: UIImageView!
    @IBOutlet weak var dataText: UILabel!
     @IBOutlet weak var shareButton: UIButton!
    var delegate : ImageDownloadDelegate? = nil
    var indexPath : IndexPath = []
    override func awakeFromNib() {
        self.dataText?.font = UIFont.systemFont(ofSize: 18)
        self.dataText?.textColor = UIColor(hex: "9E9E9E")
    //    addObserver(self, forKeyPath: #keyPath(dataImage), options: [.old, .new, .initial], context: nil)

    }
 
    override class func height() -> CGFloat {
        return 90
    }
    
    override func setData(_ data: Any?) {
//        if let data = data as? DataTableViewCellData {
//            if(data.vidObj.image == nil){
//                 //self.dataImage.delegate = self;
//            self.setRandomDownloadImage(data.imageUrl)
//           
//            }
//            else{
//                self.dataImage.image = data.vidObj.image
//            }
//            self.dataText.text = data.text
//        }
    }
   
    
    func setRandomDownloadImage(_ imageURL :String)   {
        
//        if self.dataImage.image != nil {
//            self.alpha = 1
//            return
//        }
        
        self.alpha = 0
        let url = URL(string: imageURL)!
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 15
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: url)  { (data, response, error) in
            if error != nil {
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode / 100 != 2 {
                    return
                }
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.dataImage.image = image
                        self.delegate?.imageDownloaded(image: self.dataImage.image! , indexPath: self.indexPath)
                        UIView.animate(withDuration: 0.3, animations: { () -> Void in
                            self.alpha = 1
                        }, completion: { (finished: Bool) -> Void in
                        })
                    })
                }
            }
        }
        task.resume()
    }

    
    /*
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(dataImage) {
            // Update Time Label
           print ("imageDownloded = \(dataImage.image)")
        }
    }*/
    
    
    
}
