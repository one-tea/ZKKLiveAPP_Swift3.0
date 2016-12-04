//
//  ViewListModel.swift
//  ZKKLive_Swift3.0
//
//  Created by Kevin on 16/11/29.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import UIKit
import Foundation

class ViewListModel: NSObject {

	
	/// 直播视频流
	var shareAddr:String!
	/* 关注人 */
	var onlineUsers:Int!
	/* 城市 */
	var city:String!
	/* 主播 */
	var creator:CreatorItem!
	
	 init(dataDic: NSDictionary?) {
		
		if let creatorInfo = dataDic {
			
			shareAddr = creatorInfo["stream_addr"] as! String
			onlineUsers = creatorInfo["online_users"] as! Int
			city = creatorInfo["city"] as! String
			creator = CreatorItem(creator: creatorInfo["creator"] as! NSDictionary)
		}
		
	}
	
}

class CreatorItem: NSObject {
	
	
	/// 主播名
	var nick:String!
	
	/// 主播头像
	var portrait:String!
	
	init(creator: NSDictionary) {
		nick = creator["nick"] as! String
		portrait = creator["portrait"] as! String
	}
}
