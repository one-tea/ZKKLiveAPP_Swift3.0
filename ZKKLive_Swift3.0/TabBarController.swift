//
//  TabBarController.swift
//  ZKKLive_Swift3.0
//
//  Created by Kevin on 16/11/28.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		UIApplication .shared.statusBarStyle = UIStatusBarStyle.lightContent
		
		let  viewListVC = ViewListViewController()
		let  captureVC = CaptureViewController()
		
		viewListVC.tabBarItem.image = UIImage(named: "liveList")
		captureVC.tabBarItem.image = UIImage(named: "video")
		
		viewListVC.tabBarItem.title = "直播列表"
		captureVC.tabBarItem.title = "我要直播"
		
		let viewListNav = UINavigationController(rootViewController: viewListVC)

		
		self.viewControllers = [viewListNav, captureVC]
		

	}
	


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
