//
//  RoundImage.swift
//  LifeLine
//
//  Created by Praveen V on 5/1/20.
//  Copyright © 2020 Praveen Vandeyar. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
