//
//  ViewController.swift
//  99 Red Balloons
//
//  Created by Jamie Layne on 9/17/14.
//  Copyright (c) 2014 Jamie Layne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet var balloonLabel: UILabel!
	@IBOutlet var balloonImage: UIImageView!
	@IBOutlet var nextButton: UIBarButtonItem!
	@IBOutlet var backButton: UIBarButtonItem!
	var balloons:[Balloon] = []
	var balloonIndex: Int = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		// Initialize the Balloon Array
		var lastRandomNumber: Int
		for( var balloonCount: Int = 1; balloonCount <= 99; balloonCount++ ) {
			var balloon = Balloon(number: balloonCount)
			balloons.append(balloon)
		}
		
		// display initial balloon
		loadBalloonUI(balloons[0])
		
		let forwardSwipeGesture = UISwipeGestureRecognizer()
		forwardSwipeGesture.direction = UISwipeGestureRecognizerDirection.Right
		forwardSwipeGesture.addTarget(self, action: "swipedRight")
		
		let backSwipeGesture = UISwipeGestureRecognizer()
		backSwipeGesture.direction = UISwipeGestureRecognizerDirection.Left
		backSwipeGesture.addTarget(self, action: "swipedLeft")
		
		self.view.addGestureRecognizer(backSwipeGesture)
		self.view.addGestureRecognizer(forwardSwipeGesture)
		self.view.userInteractionEnabled = true
		
		// initialize button status at the first index
		setButtonEnabledStatus(0)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func loadBalloonUI(balloon:Balloon) {
		self.balloonLabel.text = "\(balloon.number) Red Balloons"
		self.balloonImage.image = balloon.image
		if( balloon.fileName == "RedBalloon2.jpg" ) {
			self.balloonLabel.textColor = UIColor.blackColor()
		} else {
			self.balloonLabel.textColor = UIColor.whiteColor()
		}
	}
	
	func animateBalloonUI(balloon: Balloon, transition: UIViewAnimationOptions) {
		
		UIView.transitionWithView(self.view, duration: 0.5, options: transition, animations: {
			
			self.loadBalloonUI(balloon)
			
			}, completion: { (completed:Bool) -> Void in
				
		})
	}
	
	func setButtonEnabledStatus(position: Int) {
		switch position	{
			case 0:
				self.backButton.enabled = false
				self.nextButton.enabled = true
			
			case let x where x < self.balloons.count:
				self.backButton.enabled = true
				self.nextButton.enabled = true

			case let x where x == self.balloons.count:
				self.backButton.enabled = true
				self.nextButton.enabled = false
			
			default:
				// this should never happen
				self.backButton.enabled = false
				self.nextButton.enabled = false
		}
	}
	
	@IBAction func backPressed(sender: UIBarButtonItem) {
		
		
		if( balloonIndex > 0 ) {
			self.nextButton.enabled = false
			balloonIndex -= 1
			
			var balloon = self.balloons[self.balloonIndex]
			animateBalloonUI(balloon, transition: UIViewAnimationOptions.TransitionCurlDown)
			setButtonEnabledStatus(balloonIndex)
		}
	}
	
	@IBAction func nextPressed(sender: UIBarButtonItem) {
		
		
		if( balloonIndex < balloons.count-1 ) {
			self.backButton.enabled = true
			balloonIndex += 1
			var balloon = self.balloons[self.balloonIndex]
			
			animateBalloonUI(balloon, transition: UIViewAnimationOptions.TransitionCurlUp)
			setButtonEnabledStatus(balloonIndex)
		}
	}

	
	func swipedLeft() {
		
		if( balloonIndex < balloons.count-1 ) {
			self.backButton.enabled = true
			balloonIndex += 1
			var balloon = self.balloons[self.balloonIndex]
			
			animateBalloonUI(balloon, transition: UIViewAnimationOptions.TransitionFlipFromRight)
			setButtonEnabledStatus(balloonIndex)
		}
	}
	
	func swipedRight() {
		
		if( balloonIndex > 0 ) {
			self.nextButton.enabled = true
			balloonIndex -= 1
			
			var balloon = self.balloons[self.balloonIndex]
			animateBalloonUI(balloon, transition: UIViewAnimationOptions.TransitionFlipFromLeft)
			setButtonEnabledStatus(balloonIndex)
		}
	}
}

