//
//  PatternPreview.swift
//  PatternPreview
//
//  Created by Shun Kashiwa on 2021/08/01.
//

import SwiftUI
import UIKit

private struct PatternPreviewContent: UIViewRepresentable {
    let frame: CGRect
    var pattern: Pattern
    var color: UIColor

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.setContentHuggingPriority(.required, for: .horizontal) // << here !!
        view.setContentHuggingPriority(.required, for: .vertical)
        return view
    }

    // swiftlint:disable:next function_body_length
    func updateUIView(_ uiView: UIView, context: Context) {
        let bezierPath = UIBezierPath()
        let data = self.pattern.points
        let controlPoints = LineSmoother.getControlPoints(data: data)
        for i in 0..<data.count {
            let point = data[i]
            if i == 0 {
                bezierPath.move(to: point)
            } else {
                let segment = controlPoints[i - 1]
                bezierPath.addCurve(to: point, controlPoint1: segment.0, controlPoint2: segment.1)
            }
        }

        let duration = 3.0
        _ = bezierPath.fit(into: self.frame.insetBy(dx: 8, dy: 8)).moveCenter(to: self.frame.center)

        uiView.layer.sublayers = nil

        let dashedLayer = CAShapeLayer()
        dashedLayer.path = bezierPath.cgPath
        dashedLayer.strokeColor = self.color.cgColor
        dashedLayer.fillColor = nil
        dashedLayer.lineWidth = 1
        dashedLayer.lineDashPattern = [2]
        uiView.layer.addSublayer(dashedLayer)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.lineWidth = 2
        shapeLayer.strokeColor = self.color.cgColor
        shapeLayer.fillColor = nil
        shapeLayer.lineCap = .round
        uiView.layer.addSublayer(shapeLayer)
        let animation = CAKeyframeAnimation(keyPath: "strokeEnd")
        animation.values = [0.0, 1.0, 1.0, 1.0, 1.0]
        animation.keyTimes = [0.0, 0.4, 0.5, 0.9, 1.0]
        animation.duration = duration
        animation.repeatCount = .infinity
        shapeLayer.add(animation, forKey: "drawKeyAnimation")
        let endAnimation = CAKeyframeAnimation(keyPath: "strokeStart")
        endAnimation.values = [0.0, 0.0, 0.0, 1.0, 1.0]
        animation.keyTimes = [0.0, 0.4, 0.5, 0.9, 1.0]
        endAnimation.duration = duration
        endAnimation.repeatCount = .infinity
        shapeLayer.add(endAnimation, forKey: "drawKeyAnimation2")

        // arrow head
        let arrowHeadPath = UIBezierPath()
        arrowHeadPath.move(to: CGPoint(x: -5, y: 5))
        arrowHeadPath.addLine(to: CGPoint(x: 0, y: 0))
        arrowHeadPath.addLine(to: CGPoint(x: 10, y: 10))
        let arrowHeadLayer = CAShapeLayer()
        arrowHeadLayer.path = Circle().path(in: CGRect(x: -2.5, y: -2.5, width: 5.0, height: 5.0)).cgPath
        arrowHeadLayer.strokeColor = self.color.cgColor
        arrowHeadLayer.fillColor = self.color.cgColor
        arrowHeadLayer.lineWidth = 2
        uiView.layer.addSublayer(arrowHeadLayer)

        let arrowPositionAnimation = CAKeyframeAnimation(keyPath: "position")
        arrowPositionAnimation.path = shapeLayer.path
        arrowPositionAnimation.duration = 0.4 * duration
        arrowPositionAnimation.calculationMode = .paced
        arrowPositionAnimation.isRemovedOnCompletion = false
        arrowPositionAnimation.fillMode = .forwards

        let arrowAnimationGroup = CAAnimationGroup()
        arrowAnimationGroup.duration = duration
        arrowAnimationGroup.animations = [arrowPositionAnimation]
        arrowAnimationGroup.repeatCount = .infinity
        arrowHeadLayer.add(arrowAnimationGroup, forKey: nil)
    }
}

struct PatternPreview: View {
    /**
            When the view disappear and re-appears (e.g. go to another screen and come back),
            the animations stop and never restarts.
            To workaround, we increment the ID of the view on `onAppear`.
            For this reason, updates on `frame` and `pattern` will not take effect.
     */
    @State private var id = 0

    let frame: CGRect
    var pattern: Pattern
    var color: UIColor = UIColor.systemBlue

    var body: some View {
        PatternPreviewContent(
            frame: self.frame,
            pattern: self.pattern,
            color: self.color
        ).id(self.id)
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                self.id += 1
            }
            .onAppear {
                self.id += 1
            }
    }
}

struct PatternPreview_Previews: PreviewProvider {
    static var previews: some View {
        PatternPreview(
            frame: CGRect(x: 0, y: 0, width: 100, height: 100),
            pattern: Pattern(
                data: [Vector(x: 100.0, y: 0.0), Vector(x: 0.0, y: 100.0)]
            )
        )
    }
}
