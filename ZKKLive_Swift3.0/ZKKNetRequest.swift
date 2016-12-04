//
//  ZKKNetRequest.swift
//  ZKKLive_Swift3.0
//
//  Created by Kevin on 16/11/28.
//  Copyright © 2016年 Kevin. All rights reserved.
//

/* Alamofire网络请求 已经支持3.0，iOS10。 (github地址：https://github.com/Alamofire/Alamofire） 但是在项目中也不排除会出现错误可能 （Xcode ->ConVert也可以试试），这里用自己简单封装的一个网络请求  */

import UIKit

class ZKKNetRequest: NSObject {

	
	public class func get(_ url: String!, _ para: NSDictionary?, callBack: @escaping(_ data:Data? ,_ error:Error?) -> Void) -> Void{
		
		let  session = URLSession.shared
		
		let urlStr = NSMutableString.init(string: url)
		
		if let para = para {
			urlStr.append(encodeUniCode(parasToString(para) as NSString) as String)
		}
		
		var request = URLRequest(url: URL.init(string: urlStr as String)!)
		request.httpMethod = "GET"
		let dataTask = session.dataTask(with: request) { (data, responseObject, error) in

			guard let httpURLResponse = responseObject as? HTTPURLResponse, httpURLResponse.statusCode == 200,error == nil else{
				print("DataTask Error:\(error)")
				return
			}
			
			callBack(data, error);

		}
		
		dataTask.resume()
		
	}
	
	public class func post(_ url:String! , _ para:NSDictionary?, callBack: @escaping(_ data:Data? ,_ error : Error?) -> Void) -> Void{
	
		let  session = URLSession.shared;
		
		let urlStr = NSMutableString.init(string: url)
		if para != nil{
			
			urlStr.append(encodeUniCode(parasToString((para)!) as NSString) as String)

		}
		
		var request = URLRequest.init(url: URL.init(string: urlStr as String)!)
		request.httpMethod = "POST"
		let dataTask  = session.dataTask(with: request) { (data, responseObject, error) in
			
			guard let httpURLResponse = responseObject as? HTTPURLResponse, httpURLResponse.statusCode == 200, error == nil else{
			print("DataTask Error:\(error)")
			return
			}
			callBack(data,error)
		}
		
		dataTask.resume()
	
	}
	
	
	/* 特殊字符 */
	final class func encodeUniCode(_ string: NSString) ->NSString{
		
		return string.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)! as NSString
	}
	
	final class func parasToString (_ para:NSDictionary ) -> String {
		
		let paraString = NSMutableString.init(string: "?")
		for (key ,value) in para as! [String: String] {
			paraString.append("\(key)=\(value)&")
		}
		if paraString.hasSuffix("&"){
			paraString.deleteCharacters(in: NSMakeRange(paraString.length - 1, 1))
		}
		return String(paraString)
	}
}
