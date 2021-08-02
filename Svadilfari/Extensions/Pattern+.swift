//
//  Pattern+.swift
//  Pattern+
//
//  Created by Shun Kashiwa on 2021/08/01.
//

import Foundation
import CoreGraphics

extension Pattern {
    var points: [CGPoint] {
        get {
            var pts = [CGPoint(x: 0.0, y: 0.0)]
            for v in self.data {
                guard let l = pts.last else {
                    break
                }
                pts.append(CGPoint(x: v.x + l.x, y: v.y + l.y))
            }
            return pts
        }
    }
}
