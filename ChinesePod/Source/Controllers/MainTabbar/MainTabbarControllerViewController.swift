//
//  MainTabbarControllerViewController.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 22/12/2023.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        addLeftBarIcon(named: "labeled-logo")
    }
    
    func addLeftBarIcon(named:String) {
        
        let logoImage = UIImage.init(named: named)
        let logoImageView = UIImageView.init(image: logoImage)
        logoImageView.frame = CGRect(x:0.0,y:0.0, width:120,height:24.0)
        logoImageView.contentMode = .scaleAspectFit
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        let widthConstraint = logoImageView.widthAnchor.constraint(equalToConstant: 120)
        let heightConstraint = logoImageView.heightAnchor.constraint(equalToConstant: 24)
        heightConstraint.isActive = true
        widthConstraint.isActive = true
        navigationItem.leftBarButtonItem =  imageItem
//        navigationItem.rightBarButtonItems = [Headphone, LessonSearch, CourseSearch]
    }
    
    var Headphone: UIBarButtonItem {
        set { /* do nothing */ }
        get {
            let button: UIButton = UIButton(type:UIButton.ButtonType.custom)
//            let navigator = AppNavigator.sharedInstance
            button.setImage(UIImage(named: "headphones"), for: UIControl.State.normal)
//            button.addTarget(navigator, action: #selector(navigator.togglePlayerBar), for: .touchUpInside)
            button.frame = CGRectMake(0, 0, 24, 24)
            button.accessibilityLabel = "audio player"
            return UIBarButtonItem(customView: button)
        }
    }
    
    var LessonSearch: UIBarButtonItem {
        set { /* do nothing */ }
        get {
//            let navigator = AppNavigator.sharedInstance
            let button: UIButton = UIButton(type:UIButton.ButtonType.custom)
            button.setImage(UIImage(named: "search"), for: UIControl.State.normal)
//            button.addTarget(navigator, action: #selector(navigator.toggleLessonFilterBar), for: .touchUpInside)
            button.frame = CGRectMake(0, 0, 24, 24)
            return UIBarButtonItem(customView: button)
        }
    }
    
    var CourseSearch: UIBarButtonItem {
        set { /* do nothing */ }
        get {
//            let navigator = AppNavigator.sharedInstance
            let button: UIButton = UIButton(type:UIButton.ButtonType.custom)
            button.setImage(UIImage(named: "search"), for: UIControl.State.normal)
//            button.addTarget(navigator, action: #selector(navigator.toggleCourseFilterBar), for: .touchUpInside)
            button.frame = CGRectMake(0, 0, 24, 24)
            button.accessibilityLabel = "search"
            return UIBarButtonItem(customView: button)
        }
    }
}

extension MainTabbarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is AccountViewController {
            let loginVC = Constants.mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(loginVC, animated: true)
            return false
        }
        return true
    }
}
