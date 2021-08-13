//
//  CGPoint+init.swift
//  CGPoint+init
//
//  Created by Shun Kashiwa on 2021/08/01.
//

import CoreGraphics

extension Vector {
    var point: CGPoint {
        return CGPoint(x: self.x, y: self.y)
    }

    static var Top: Self {
        return Self.init(x: 0, y: -100)
    }
    static var TopRight: Self {
        return Self.init(x: 100, y: -100)
    }
    static var Right: Self {
        return Self.init(x: 100, y: 0)
    }
    static var BottomRight: Self {
        return Self.init(x: 100, y: 100)
    }
    static var Bottom: Self {
        return Self.init(x: 0, y: 100)
    }
    static var BottomLeft: Self {
        return Self.init(x: -100, y: 100)
    }
    static var Left: Self {
        return Self.init(x: -100, y: 0)
    }
    static var TopLeft: Self {
        return Self.init(x: -100, y: -100)
    }
}
