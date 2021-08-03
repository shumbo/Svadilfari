//
//  UIBezierPath+.swift
//  UIBezierPath+
//
//  Created by Shun Kashiwa on 2021/08/01.
//

import Foundation
import UIKit

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: self.size.width/2.0, y: self.size.height/2.0)
    }
}

extension CGPoint {
    func vector(to p1: CGPoint) -> CGVector {
        return CGVector(dx: p1.x - x, dy: p1.y - y)
    }
}

extension UIBezierPath {
    func moveCenter(to: CGPoint) -> Self {
        let bounds = self.cgPath.boundingBox
        let center = bounds.center

        let zeroedTo = CGPoint(x: to.x - bounds.origin.x, y: to.y - bounds.origin.y)
        let vector = center.vector(to: zeroedTo)

        _ = offset(to: CGSize(width: vector.dx, height: vector.dy))
        return self
    }

    func offset(to offset: CGSize) -> Self {
        let t = CGAffineTransform(translationX: offset.width, y: offset.height)
        _ = applyCentered(transform: t)
        return self
    }

    func fit(into: CGRect) -> Self {
        let bounds = self.cgPath.boundingBox

        let sw     = into.size.width/bounds.width
        let sh     = into.size.height/bounds.height
        let factor = min(sw, max(sh, 0.0))

        return scale(x: factor, y: factor)
    }

    func scale(x: CGFloat, y: CGFloat) -> Self {
        let scale = CGAffineTransform(scaleX: x, y: y)
        _ = applyCentered(transform: scale)
        return self
    }

    func applyCentered(transform: @autoclosure () -> CGAffineTransform ) -> Self {
        let bound  = self.cgPath.boundingBox
        let center = CGPoint(x: bound.midX, y: bound.midY)
        var xform  = CGAffineTransform.identity

        xform = xform.concatenating(CGAffineTransform(translationX: -center.x, y: -center.y))
        xform = xform.concatenating(transform())
        xform = xform.concatenating(CGAffineTransform(translationX: center.x, y: center.y))
        apply(xform)

        return self
    }
}
