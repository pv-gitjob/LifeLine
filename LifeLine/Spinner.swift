//
//  Spinner.swift
//  LifeLine
//
//  Created by Praveen V on 4/29/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import UIKit

extension UIView{
    
    func customActivityIndicator(view: UIView, widthView: CGFloat? = nil,backgroundColor: UIColor? = nil, message: String? = nil,colorMessage:UIColor? = nil ) -> UIView {

        self.backgroundColor = UIColor.black.withAlphaComponent(0.7) // UIColor is color and alpha component is transparency

        var selfWidth = view.frame.width
        if widthView != nil{
            selfWidth = widthView ?? selfWidth
        }

        let selfHeigh = view.frame.height
        let selfFrameX = (view.frame.width / 2) - (selfWidth / 2)
        let selfFrameY = (view.frame.height / 2) - (selfHeigh / 2)
        let loopImages = UIImageView()

        //ConfigCustomLoading with secuence images
        let imageListArray = [UIImage(named:"Load_1"), UIImage(named:"Load_2"), UIImage(named:"Load_3"), UIImage(named:"Load_4"), UIImage(named:"Load_5"), UIImage(named:"Load_6"), UIImage(named:"Load_7"), UIImage(named:"Load_8")] // This is an array, keep adding images to add to the animation
        loopImages.animationImages = imageListArray as? [UIImage]
        loopImages.animationDuration = TimeInterval(0.3) // Seconds between each image
        loopImages.startAnimating()
        let imageFrameX = (selfWidth / 2) - 75 // Placement of image
        let imageFrameY = (selfHeigh / 2) - 150 // Placement of image
        var imageWidth = CGFloat(150) // Size of image
        var imageHeight = CGFloat(150) // Size of image

        if widthView != nil{
            imageWidth = widthView ?? imageWidth
            imageHeight = widthView ?? imageHeight
        }

        //ConfigureLabel
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.text = message ?? ""
        label.textColor = colorMessage ?? UIColor.clear

        //Config frame of label
        let labelFrameX = (selfWidth / 2) - 100
        let labelFrameY = (selfHeigh / 2) - 10
        let labelWidth = CGFloat(200)
        let labelHeight = CGFloat(70)

        //add loading and label to customView
        self.addSubview(loopImages)
        self.addSubview(label)

        //Define frames
        //UIViewFrame
        self.frame = CGRect(x: selfFrameX, y: selfFrameY, width: selfWidth , height: selfHeigh)

        //ImageFrame
        loopImages.frame = CGRect(x: imageFrameX, y: imageFrameY, width: imageWidth, height: imageHeight)

        //LabelFrame
        label.frame = CGRect(x: labelFrameX, y: labelFrameY, width: labelWidth, height: labelHeight)

        return self

    }

}
