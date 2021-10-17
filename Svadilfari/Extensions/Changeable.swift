//
//  Changeable.swift
//  Svadilfari
//
//  Created by Shun Kashiwa on 2021/10/07.
//

// Taken from https://stackoverflow.com/a/66623586/4519449

import Foundation

protocol Changeable {}

extension Changeable {
    func change<T>(path: WritableKeyPath<Self, T>, to value: T) -> Self {
        var clone = self
        clone[keyPath: path] = value
        return clone
    }
}
