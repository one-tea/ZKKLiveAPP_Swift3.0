//
//  ViewListViewController.swift
//  ZKKLive_Swift3.0
//
//  Created by Kevin on 16/11/28.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import UIKit


class ViewListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
	
	
	/* 属性 */
	let url = "http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1"
	var dataArry  = [ViewListModel]()
	
	static let cellId = "viewListCell"
	
	/* 懒加载 */
	lazy var tableView:UITableView = {
		
		let tableView = UITableView(frame: self.view.bounds, style:.plain)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.showsVerticalScrollIndicator = false;
		tableView.register(UINib.init(nibName: "ViewListTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
		tableView.separatorStyle = .none
		self.view.addSubview(tableView)

		return tableView
	}()
	
	
	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.98, green: 0.4, blue: 0.4, alpha: 1)
		self.navigationController?.navigationBar.backIndicatorImage = UIImage()
		
		self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 17),NSForegroundColorAttributeName:UIColor.white]
		
		
		self.navigationItem.title = "直播列表"
		self.navigationController?.navigationBar.isTranslucent = false
		self.tabBarController?.tabBar.isHidden = false
		
		
	}
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		
		/* 数据 */
		ViewListManager.get(URL:url, Para: nil) { (dataArry) in
			
			if !self.dataArry.isEmpty {
				self.dataArry.removeAll()
			}
			self.dataArry = dataArry
			
//			print(self.dataArry)
			DispatchQueue.main.async(execute: {
	
				self.tableView.reloadData()
			})
		}
		
		
	}
	
	// MARK: tableView delegate
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.dataArry.count
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 430
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let  cell = ViewListManager.setCell(tableView: tableView, identifier: ViewListViewController.cellId, data: dataArry, indexPath: indexPath)
		
		return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let  model = self.dataArry[indexPath.row]
		let  livePlay = LiveViewController()
		
		livePlay.liveModel = model
//		livePlay.modalTransitionStyle = .crossDissolve
		self.present(livePlay, animated: true, completion: nil)
		
	}
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		cell.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1)
		UIView.animate(withDuration: 0.8, animations: {
			cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
		}, completion: nil)
		
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
