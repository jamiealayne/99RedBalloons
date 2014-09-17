//
//  Balloon.swift
//  99 Red Balloons
//
//  Created by Jamie Layne on 9/17/14.
//  Copyright (c) 2014 Jamie Layne. All rights reserved.
//

import Foundation
import UIKit

struct Balloon {
	var number: Int = 0
	var image: UIImage = UIImage(named: "")
	var fileName: String = ""
	
	static var lastRandomImageIndex = 0
	
	init(number: Int) {
		self.number = number
		image = self.getRandomImage()
	}
	
	// mutating function to set and remember the last random number that was used
	mutating func getRandomImage() -> UIImage {
		var randomIndex: Int
		
		do {
			randomIndex = Int( arc4random_uniform(5) )
		} while randomIndex == Balloon.lastRandomImageIndex
		Balloon.lastRandomImageIndex = randomIndex
		
		let imageName = "RedBalloon\(randomIndex).jpg"
		self.fileName = imageName
		return UIImage(named: imageName)
	}
	
	
}