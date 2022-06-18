//
//  CommonHelper.swift
//  TaskExecuter
//
//  Created by Ahmed Abuelmagd on 18/06/2022.
//

import UIKit

public var screenWidth: CGFloat { get { return UIScreen.main.bounds.size.width } }
public var screenHeight:CGFloat { get { return UIScreen.main.bounds.size.height } }
public var iPhoneXFactor: CGFloat { get {return ((screenWidth * 1.00) / 360.0)} }
public var iPhoneYFactor: CGFloat { get {return ((screenHeight * 1.00) / 667.0)} }
