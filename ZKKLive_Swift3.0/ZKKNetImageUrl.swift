//
//  ZKKNetWithUrl.swift
//  ZKKLive_Swift3.0
//
//  Created by Kevin on 16/11/29.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import UIKit

extension  UIImageView {

 
	func zk_getImageWithUrl(urlString:String , defaultImage:UIImage? ) -> Void{
		
		
//		/* 是否缓存 */
//		var isCacle = true
//		
//		if isCacle == true {
//			
//		}
		
		if let defaultImage = defaultImage {
			self.image = defaultImage//默认
		}
		
		/* 加载 */
		
		DispatchQueue.global().async { 
			
			let request = URLRequest(url: URL.init(string: urlString as String)!)
			
			URLSession.shared.dataTask(with: request) { (data, response, error) in
				guard
					let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
					let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
					let data = data, error == nil,
					let image = UIImage(data: data)
					else { return }
				
				self.contentMode = UIViewContentMode.scaleToFill
				DispatchQueue.main.async(execute: {
					self.image = image
				})
				}.resume()

			
		}
		
		
		/* 缓存后续在添加，当然无法与SDImage性能相媲美，等待稳定版本合适的第三方框架再用吧 */
		
		
	}
}
