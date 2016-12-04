//
//  LiveViewController.swift
//  
//
//  Created by Kevin on 16/11/30.
//
//

import UIKit
import Foundation
import IJKMediaFramework


class LiveViewController: UIViewController  {

	@IBOutlet weak var backBtn: UIButton!
	@IBAction func backBtn(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	
	//MARK: - Getters and Setters

	var liveModel:ViewListModel!
	
	var  ijkLivePlay:IJKFFMoviePlayerController!
	
		override func viewDidLoad() {
			super.viewDidLoad()
			self.view.backgroundColor = UIColor.clear
			
			let requestUrl = URL.init(string:liveModel.shareAddr!)

			ijkLivePlay = IJKFFMoviePlayerController.init(contentURL: requestUrl, with: nil)!
			ijkLivePlay.view.frame = UIScreen.main.bounds
			
			self.view.addSubview(ijkLivePlay.view)
			self.view.insertSubview(backBtn, aboveSubview: self.ijkLivePlay.view)
			
			ijkLivePlay.prepareToPlay()
			
		}

		override func viewWillDisappear(_ animated: Bool) {
			super.viewWillDisappear(true)
			
			/* 释放 */
			if	ijkLivePlay != nil {
				ijkLivePlay.pause()
				ijkLivePlay.stop()
				ijkLivePlay.shutdown()
			}
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
