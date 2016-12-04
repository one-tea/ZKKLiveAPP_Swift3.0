//
//  CaptureViewController.swift
//  ZKKLive_Swift3.0
//
//  Created by Kevin on 16/11/28.
//  Copyright © 2016年 Kevin. All rights reserved.
//

import UIKit
import LFLiveKit
import AVFoundation

class CaptureViewController: UIViewController,LFLiveSessionDelegate {

	@IBAction func backBtn(_ sender: UIButton) {
		let  tabbar = TabBarController()
		UIApplication.shared.keyWindow?.rootViewController = tabbar
		tabbar.tabBarController?.tabBar.isHidden = false
	}
	@IBAction func beautyBtn(_ sender: UIButton) {
		sender.isSelected = !sender.isSelected
		self.session.beautyFace = !self.session.beautyFace
	}
	@IBAction func changeCarmeraBtn(_ sender: UIButton) {
		let position = self.session.captureDevicePosition
		self.session.captureDevicePosition = (position == AVCaptureDevicePosition.back) ?AVCaptureDevicePosition.front : AVCaptureDevicePosition.back
	}
	
	@IBOutlet weak var linkingStateLb: UILabel!
	@IBOutlet weak var beautyBtn: UIButton!
	@IBOutlet weak var changeCarmeraBtn: UIButton!
	
	
	//MARK: - Getters and Setters
	lazy var session: LFLiveSession = {
		let audioConfiguration = LFLiveAudioConfiguration.default()
		let videoConfiguration = LFLiveVideoConfiguration.defaultConfiguration(for: LFLiveVideoQuality.low3)
		let session = LFLiveSession(audioConfiguration: audioConfiguration, videoConfiguration: videoConfiguration)
		
		session?.delegate = self
		session?.preView = self.view
		return session!
	}()
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillDisappear(true)
		self.tabBarController?.tabBar.isHidden = true
		
		startLive()
		requestAccessForAudio()
		requestAccessForVideo()
		
	}
    override func viewDidLoad() {
        super.viewDidLoad()

		
	}
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(true)
		stopLive()
	}
	func requestAccessForVideo()  {
		weak var _self = self
		let state = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
		switch state {
		case .notDetermined:
			AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (grandted) in
				guard grandted else { return }
				DispatchQueue.main.async(execute: { 
				_self?.session.running = true
				})
			})
		case.authorized:
			AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (grandted) in
				guard grandted else { return }
				DispatchQueue.main.async(execute: {
					_self?.session.running = true
				})
			})
			break
		case.denied:break
		case.restricted:break
		
		
		}
		
	}
	
	func requestAccessForAudio()  {
		let state = AVCaptureDevice.authorizationStatus(forMediaType:AVMediaTypeAudio)
		switch state {
		case .notDetermined:
			AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeAudio, completionHandler: { (granted) in
				guard granted else{
					return
				}
				
				/* TODO: */
			})
		case .authorized: break
		case .denied: break
		case .restricted: break

	    }
    }

	func startLive() {
		let stream = LFLiveStreamInfo()
		stream.url = "rtmp://192.168.0.2:1935/rtmplive/room"
		self.session.startLive(stream)

		
	}
	func stopLive() {
		self.session.stopLive()
	}

	
	//MARK: - LFStreamingSessionDelegate
	
	func liveSession(_ session: LFLiveSession?, liveStateDidChange state: LFLiveState) {
		switch state {
		case .ready:
			self.linkingStateLb.text = "未链接"
		case .pending:
			self.linkingStateLb.text = "链接中..."
		case .start:
			self.linkingStateLb.text = "开始链接"
		case .stop:
			self.linkingStateLb.text = "断开链接"
		case .error:
			self.linkingStateLb.text = "链接错误"
		}
	}
	
	func liveSession(_ session: LFLiveSession?, debugInfo: LFLiveDebug?) {
		print("debugInfo:\(debugInfo)")
	}
	func liveSession(_ session: LFLiveSession?, errorCode: LFLiveSocketErrorCode) {
		print("errorCode:\(errorCode)")
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
