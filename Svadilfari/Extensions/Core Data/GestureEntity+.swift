//
//  GestureEntity+.swift
//  GestureEntity+
//
//  Created by Shun Kashiwa on 2021/08/03.
//

import CoreData

extension GestureEntity {
    var gesture: Gesture {
        // swiftlint:disable implicit_getter
        get throws {
            guard let json = self.json else {
                throw EntityError.invalidJson
            }
            return try Gesture(json)
        }
    }
    func setGesture(gesture: Gesture) throws {
        self.json = try gesture.jsonString()
    }
}
