//
//  StringExtendion.swift
//  ZKKLive_Swift3.0
//
//  Created by Kevin on 16/11/29.
//  Copyright © 2016年 Kevin. All rights reserved.
//
import Foundation
import UIKit
extension String{
	
	 mutating func attributedString(string:String?) -> NSMutableAttributedString {
		
		var attributedString: NSMutableAttributedString!
		
		if  let string = string {
		
			let fullStr = NSString(string: self)
			
			let range = fullStr.range(of: string)
			
			attributedString = NSMutableAttributedString.init(string: fullStr as String)
			
			attributedString.addAttribute(NSFontAttributeName, value: UIFont(name: "Helvetica-Bold", size: 13)!, range: range)
			attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: range)
			
		}
		return attributedString

		
	}
	
}
