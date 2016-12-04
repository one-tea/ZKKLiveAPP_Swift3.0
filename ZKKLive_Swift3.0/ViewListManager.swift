//
//  ViewListManager.swift
//  ZKKLive_Swift3.0
//
//  Created by Kevin on 16/11/28.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import UIKit

typealias Model = ViewListModel

class ViewListManager: NSObject {
	
	/* 数据请求 */
	class func get(URL url: String!, Para paramaters: NSDictionary?, finished: @escaping (_ dataArry: [Model]) -> Void ) -> Void {
		
		var  dataArry = [ViewListModel]()
		
		ZKKNetRequest.get(url, paramaters) { (data, error) in
		
			let obj = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
//			print("live:" + "\(obj)")
			if let lives = obj?["lives"] {
				
				for live in lives as! NSArray{
					
					if let live = live as? NSDictionary {
						
						 dataArry.append(Model(dataDic:live))
					}
				}				

			}
			
			finished(dataArry)
		}
	}
	
	class func setCell(tableView:UITableView, identifier: String, data:[ViewListModel], indexPath:IndexPath) -> UITableViewCell{
		
		let  cell = tableView.dequeueReusableCell(withIdentifier:identifier) as! ViewListTableViewCell
		
		let  model = data[indexPath.row]
		var  concernStr = String(model.onlineUsers) + "人在看"
		
		var  imageUrl = model.creator.portrait
		
		
		/* 处理特殊图片地址 */
		if (imageUrl?.hasPrefix("http://img2.inke.cn/"))! == false {
			imageUrl = "http://img.meelive.cn/" + model.creator.portrait
		}
		
		/* cell设置 */
		cell.icoImageView.zk_getImageWithUrl(urlString: imageUrl! ,defaultImage: UIImage(named: "defultImage"))
		cell.nameLB.text = model.creator.nick
		cell.locationLB.text = model.city
		cell.concernNumLB.attributedText = concernStr.attributedString(string:String(model.onlineUsers))
		cell.bgImageView.zk_getImageWithUrl(urlString: imageUrl! ,defaultImage: UIImage(named: "me_new_icon_live"))
		cell.selectionStyle = .none
		
		return cell
	}
	
	
}
