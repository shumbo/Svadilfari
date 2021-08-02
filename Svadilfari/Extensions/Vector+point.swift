//
//  CGPoint+init.swift
//  CGPoint+init
//
//  Created by Shun Kashiwa on 2021/08/01.
//

import CoreGraphics

extension Vector {
    var point: CGPoint {
        get {
            return CGPoint(x: self.x, y: self.y)
        }
    }
}
