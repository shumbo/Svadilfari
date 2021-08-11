//
//  GestureEntity+.swift
//  GestureEntity+
//
//  Created by Shun Kashiwa on 2021/08/03.
//

import CoreData

extension GestureEntity {
    var gesture: Gesture? {
        get {
            guard let json = self.json, let g = try? Gesture(json) else {
                return nil
            }
            return g
        }
        set(g) {
            guard let json = try? g?.jsonString() else {
                return
            }
            self.json = json
        }
    }
    func setGesture(gesture: Gesture) throws {
        self.json = try gesture.jsonString()
    }
}
