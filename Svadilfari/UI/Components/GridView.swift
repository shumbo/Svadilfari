//
//  GridView.swift
//  GridView
//
//  Created by Shun Kashiwa on 2021/08/14.
//

import SwiftUI

struct GridView: View {
    var gridSize: CGFloat
    var circleSize: CGFloat
    var body: some View {
        Canvas { context, size in
            // draw a grid
            let column = Int(size.width / self.gridSize)
            let columnSize = size.width / CGFloat(column)
            let columnOffset = (size.width.truncatingRemainder(dividingBy: self.gridSize) - 1) * columnSize / 2
            // let columnOffset = 10.0
            let row = Int(size.height / self.gridSize)
            let rowSize = size.height / CGFloat(row)
            let rowOffset = (size.height.truncatingRemainder(dividingBy: self.gridSize) - 1) * rowSize / 2
            for i in 0...column {
                for j in 0...row {
                    context.fill(Circle()
                        .path(in: CGRect(
                            x: columnOffset + columnSize * CGFloat(i),
                            y: rowOffset + rowSize * CGFloat(j),
                            width: self.circleSize, height: self.circleSize)),
                            with: .color(.secondary)
                    )
                }
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(gridSize: 30.0, circleSize: 4.0)
    }
}
