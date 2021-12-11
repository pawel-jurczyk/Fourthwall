//
//  UIImageView+ScaledSize.swift
//  Fourthwall
//
//  Created by Pawel on 12/11/21.
//

import UIKit

extension UIImageView {
    var scaledSize: CGSize {
        let scale = UIScreen.main.scale
        return bounds.size.applying(.init(scaleX: scale, y: scale))
    }
}
