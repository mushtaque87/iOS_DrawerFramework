//
//  ViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit
import SlideMenuControllerSwift


class MainViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    
    var searchActive : Bool = false
    var searchString = ""
    var newSearchString  = ""

    var maxCount = 0
     var searchMaxCount = 0
    var nextPageToken:NSString = ""
    @IBOutlet weak var activityindicator : UIActivityIndicatorView!
    
        //= ["data1", "data2", "data3", "data4", "data5", "data6", "data7", "data8", "data9", "data10", "data11", "data12", "data13", "data14", "data15"]
    
   //"channelId": "UCooe8FmsQSI-Hs70Hz53fxg",
    
    
   //#define youTubeURL [NSURL URLWithString: @"https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=PLNngVRDXb8azV_H7ZkX6cl6RCdSF6_trz&key=AIzaSyCOMLqATGL5jS_UAp79mBkpzf-lN58y0R0&maxResults=20"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.registerCellNib(DataTableViewCell.self)
      //  startHttpConnection();
        self.definesPresentationContext = true
        
        let searchbar : UISearchBar = UISearchBar();
       // searchbar.delegate = self
        searchbar.placeholder = "Search the whole channel"
        searchbar.returnKeyType = UIReturnKeyType.search
        self.navigationItem.titleView =  searchbar
        self.definesPresentationContext = true;

        
//        let searchController : UISearchController = UISearchController();
//        self.tableView.addSubview( searchController.view) 
        
        /*
        let search:UITextField = UITextField();
        //    search.delegate = self
        search.placeholder = "Search the whole channel"
        search.backgroundColor = UIColor.black
        search.isUserInteractionEnabled = true
        search.isEnabled = true;
        search.becomeFirstResponder()
        self.navigationItem.titleView = search*/
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       self.setNavigationBarItem()
     
        /*
        let search:UITextField = UITextField();
    //    search.delegate = self
        search.placeholder = "Search the whole channel"
        search.backgroundColor = UIColor.black
        search.isUserInteractionEnabled = true
        search.isEnabled = true;
        search.becomeFirstResponder()
        self.navigationItem.titleView = search
 */
        /*
        let searchbar : UISearchBar = UISearchBar();
        searchbar.delegate = self
        searchbar.placeholder = "Search the whole channel"
       searchbar.returnKeyType = UIReturnKeyType.search
        self.navigationItem.titleView =  searchbar
        self.definesPresentationContext = true;
        */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /*
    func startHttpConnection()
    {
        maxCount = maxCount + 8
  
        let url = URL(string: "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=PLNngVRDXb8azV_H7ZkX6cl6RCdSF6_trz&key=AIzaSyCOMLqATGL5jS_UAp79mBkpzf-lN58y0R0&pageToken=\(nextPageToken)&maxResults=\(maxCount)")

        activityindicator.startAnimating()
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error ?? "Connection Failed")
                DispatchQueue.main.async {
                    self.activityindicator.stopAnimating()
                }
                return
            }
            guard let data = data else {
                print("Data is empty")
                DispatchQueue.main.async {
                    self.activityindicator.stopAnimating()
                }
                return
            }
          
            let json: NSDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
            print(json)
            
            let videoArray:NSArray = json.object(forKey: "items") as! NSArray
         //   self.mainContens.removeAll()
            if(self.maxCount >= 48)
            {
                self.maxCount = 0
                if(json["nextPageToken"] != nil)
                {
                self.nextPageToken = json.object(forKey: "nextPageToken") as! NSString
                }
            }
            for count in 0..<videoArray.count
            {
                let vid  = VideoObject()
                let snippetDict: NSDictionary = videoArray.object(at:count )  as! NSDictionary;
                vid.id = snippetDict.object(forKey: "id") as! NSString
                let snippet: NSDictionary = snippetDict.object(forKey: "snippet") as! NSDictionary
                vid.title = snippet.object(forKey: "title") as! NSString!
             //   vid.descp =  snippet.object(forKey: "description") as! NSString!
                
                var description = snippet.object(forKey: "description") as! String!
                if description?.range(of: "Click" ) != nil  {
                    let range: Range<String.Index>? = description?.range(of: "Click")!
                    let index = description!.distance(from: description!.startIndex, to: (range?.lowerBound)!)
                    let descpindex = description?.index((description?.startIndex)!, offsetBy: index)
                    vid.descp = description?.substring(to: descpindex!) as! NSString
                }else{
                    vid.descp = snippet.object(forKey: "description")  as! NSString!
                }
                
                let resourceId: NSDictionary = snippet.object(forKey: "resourceId") as! NSDictionary
                vid.videoId = resourceId.object(forKey: "videoId") as! NSString
                let thumbnails: NSDictionary  =  snippet.object(forKey: "thumbnails") as! NSDictionary
                let defaulturl: NSDictionary  =  thumbnails.object(forKey: "default") as! NSDictionary
                vid.imageURL =  defaulturl.object(forKey: "url") as! NSString!
               
                var ispresent : Bool = false
                for vidcount in 0..<self.mainContens.count
                {
                     let tmpVid : VideoObject = self.mainContens[vidcount]
                    if(vid.id == tmpVid.id)
                    {
                        ispresent = true
                        break
                    }
                }
                if(ispresent == false)
                {
                self.mainContens.append(vid)
                }
            }
            DispatchQueue.main.async {
                   self.activityindicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
        
        task.resume()
    }
    */
    /*
    func share(sender: AnyObject)
    {
        let button = sender as! UIButton
        let vid : VideoObject = mainContens[button.tag]
        let objectsToShare = [vid.title,"https://www.youtube.com/embed/\(vid.videoId)","\n\n","\n","Subscribe SDI Channel on Youtube","Download Android and iOS app","\n","\n","Follow us on Facebook | Twitter | Instagram"] as [Any];
        
        //http://stackoverflow.com/questions/30137418/ios-swift-sharing-on-whatsapp-and-fb
        let activityVC = UIActivityViewController(activityItems: objectsToShare , applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.postToTwitter, UIActivityType.postToFacebook, UIActivityType.addToReadingList,UIActivityType.copyToPasteboard]
        
        self.present(activityVC, animated: true, completion: nil)
    }
    */
    
    /*
    func startSearch()
    {
        searchMaxCount = searchMaxCount + 10
       
        if(newSearchString  != searchString){
         //   self.searchContens.removeAll()
            newSearchString = searchString
        }
        let url = URL(string: "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=UCooe8FmsQSI-Hs70Hz53fxg&key=AIzaSyCOMLqATGL5jS_UAp79mBkpzf-lN58y0R0&q=\(newSearchString)&maxResults=\(searchMaxCount)")
        
        //https://www.googleapis.com/youtube/v3/videos?part=statistics&id=qdyLpdu68J0&key=AIzaSyCOMLqATGL5jS_UAp79mBkpzf-lN58y0R0
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error ?? "Connection Failed")
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
        
            
            let json: NSDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
            print(json)
            
            let videoArray:NSArray = json.object(forKey: "items") as! NSArray
            
            if(videoArray.count == 0)
            {
                let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

            }
            
            for count in 0..<videoArray.count
            {
                let vid  = VideoObject()
                let snippetDict: NSDictionary = videoArray.object(at:count )  as! NSDictionary;
                let snippet: NSDictionary = snippetDict.object(forKey: "snippet") as! NSDictionary
                vid.title = snippet.object(forKey: "title") as! NSString!
                let resourceId: NSDictionary = snippetDict.object(forKey: "id")as! NSDictionary
                vid.videoId = resourceId.object(forKey: "videoId") as! NSString
                let thumbnails: NSDictionary  =  snippet.object(forKey: "thumbnails") as! NSDictionary
                let defaulturl: NSDictionary  =  thumbnails.object(forKey: "default") as! NSDictionary
                vid.imageURL =  defaulturl.object(forKey: "url") as! NSString!
                self.searchContens.append(vid)
            }
          //  self.tableView.reloadData()
            
            DispatchQueue.main.async {
               // self.tableView.reloadData()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let subContentsVC = storyboard.instantiateViewController(withIdentifier: "SpeakerListViewController") as! SpeakerListViewController
                subContentsVC.mainContens.removeAll()
                subContentsVC.mainContens = self.searchContens;
                self.navigationController?.pushViewController(subContentsVC, animated: true)
            }
       

        }
        
        task.resume()
    }
    */
 /*
@IBAction func loadMore()
{
    startHttpConnection()
    }

}
*/
    /*
extension MainViewController:UISearchBarDelegate {
func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchActive = true;
}

func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    searchActive = false;
    
}

func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchActive = false;
}
 */

    /*
func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = nil
    if(searchActive == true){
      //  startSearch()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let subContentsVC = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        subContentsVC.searchString = searchString
        self.navigationController?.pushViewController(subContentsVC, animated: true)
    }
    
    searchBar.resignFirstResponder()
    searchActive = false;
 
    
}
*/
func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    print(searchText)
    searchString = searchText
   /* filtered = data.filter({ (text) -> Bool in
        let tmp: NSString = text
        let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
        return range.location != NSNotFound
    })
    if(filtered.count == 0){
        searchActive = false;
    } else {
        searchActive = true;
    }
    self.tableView.reloadData()
*/
    }
    /*
    func imageDownloaded(image:UIImage , indexPath:IndexPath)
    {
        
      let vid : VideoObject = mainContens[indexPath.row]
        vid.image = image
         print("imageDownloade  for \(vid.title)")
        mainContens[indexPath.row] = vid
      //    self.tableView.reloadData()
    }
    */
}

/*

extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DataTableViewCell.height()
    }
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let subContentsVC = storyboard.instantiateViewController(withIdentifier: "VideoPlayerScreen") as! VideoPlayerViewController
        subContentsVC.vidObj = mainContens[indexPath.row];
        self.navigationController?.pushViewController(subContentsVC, animated: true)
 
    }
}

extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainContens.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: DataTableViewCell.identifier) as! DataTableViewCell
        cell.indexPath = indexPath
        cell.delegate = self
      
        let vid : VideoObject = mainContens[indexPath.row]
       // let data = DataTableViewCellData(imageUrl: vid.imageURL as String, text: vid.title as String , v)
         let data = DataTableViewCellData(imageUrl:  vid.imageURL as String , text: vid.title as String, vidobj: vid as VideoObject)
        cell.setData(data)
        
        cell.shareButton.addTarget(self, action: #selector(share(sender:)), for: .touchUpInside)
        cell.shareButton.tag = indexPath.row
        
        return cell
    }

}
 */

extension MainViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}
