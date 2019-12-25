//
//  UIImage+YLColor.swift
//  YLDatePicker
//
//  Created by Yeonluu on 2019/12/2.
//  Copyright © 2019 Yeonluu. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    public class func imageWithColor(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
    
}
