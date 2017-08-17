//
//  LeftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

enum LeftMenu: Int {
    case main = 0
    case FirstTab
    case SecondTab
    case ThirdTab
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController : UIViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var menus = ["FirstTab", "SecondTab", "ThirdTab"]
    var mainViewController: UIViewController!
    var firstTab_ViewController: UIViewController!
    var secondTab_ViewController: UIViewController!
    var thirdTab_ViewController: UIViewController!
//    var shortClipViewController: UIViewController!
//      var speechesViewController: UIViewController!
//    var specialViewController: UIViewController!
//    var aboutViewController: UIViewController!
//    var nonMenuViewController: UIViewController!
    var imageHeaderView: ImageHeaderView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
        
        let firstTab_ViewController = storyboard.instantiateViewController(withIdentifier: "FirstTab_ViewController") as! FirstTab_ViewController
        self.firstTab_ViewController = UINavigationController(rootViewController: firstTab_ViewController)
        
        
        let secondTab_ViewController = storyboard.instantiateViewController(withIdentifier: "SecondTab_ViewController") as! SecondTab_ViewController  
        self.secondTab_ViewController = UINavigationController(rootViewController: secondTab_ViewController)
        
        let thirdTab_ViewController = storyboard.instantiateViewController(withIdentifier: "ThridTab_ViewController") as! ThridTab_ViewController
        self.thirdTab_ViewController = UINavigationController(rootViewController: thirdTab_ViewController)
        /*
        let shortClipViewController = storyboard.instantiateViewController(withIdentifier: "ShortClip") as! ShortClip
        self.shortClipViewController = UINavigationController(rootViewController: shortClipViewController)

        
        let specialViewController = storyboard.instantiateViewController(withIdentifier: "Special") as! Special
        self.specialViewController = UINavigationController(rootViewController: specialViewController)

        let speechesViewController = storyboard.instantiateViewController(withIdentifier: "Speeches") as! Speeches
        self.speechesViewController = UINavigationController(rootViewController: speechesViewController)
        
        let aboutViewController = storyboard.instantiateViewController(withIdentifier: "About") as! About
        self.aboutViewController = UINavigationController(rootViewController: aboutViewController)
    */
        /*
        let nonMenuController = storyboard.instantiateViewController(withIdentifier: "NonMenuController") as! NonMenuController
        nonMenuController.delegate = self
        self.nonMenuViewController = UINavigationController(rootViewController: nonMenuController)
        */
        
        self.tableView.registerCellClass(BaseTableViewCell.self)
        
        self.imageHeaderView = ImageHeaderView.loadNib()
        self.view.addSubview(self.imageHeaderView)
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imageHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 160)
        self.view.layoutIfNeeded()
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .main:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .FirstTab:
            self.slideMenuController()?.changeMainViewController(self.firstTab_ViewController, close: true)
        case .SecondTab:
            self.slideMenuController()?.changeMainViewController(self.secondTab_ViewController, close: true)
        case .ThirdTab:
            self.slideMenuController()?.changeMainViewController(self.thirdTab_ViewController, close: true)
//        case .shortclip:
//            self.slideMenuController()?.changeMainViewController(self.shortClipViewController, close: true)
//        case .special:
//            self.slideMenuController()?.changeMainViewController(self.specialViewController, close: true)
//        case .speeches:
//            self.slideMenuController()?.changeMainViewController(self.speechesViewController, close: true)
//        case .about:
//            self.slideMenuController()?.changeMainViewController(self.aboutViewController, close: true)
//        case .nonMenu:
//            self.slideMenuController()?.changeMainViewController(self.nonMenuViewController, close: true)
        }
    }
}

extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .main, .FirstTab, .SecondTab, .ThirdTab:
                return BaseTableViewCell.height()
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}

extension LeftViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .main, .FirstTab,.SecondTab,.ThirdTab:
                let cell = BaseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
                cell.setData(menus[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}
