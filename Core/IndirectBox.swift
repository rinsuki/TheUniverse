//
//  IndirectBox.swift
//  TheUniverse
//
//  Created by user on 2021/07/27.
//

import Foundation

enum IndirectBox<T> {
    indirect case box(T)
    
    var value: T {
        switch self {
        case .box(let value):
            return value
        }
    }
    
    init(_ value: T) {
        self = .box(value)
    }
}

extension IndirectBox: Decodable where T: Decodable {
    init(from decoder: Decoder) throws {
        self = .box(try T(from: decoder))
    }
}

extension IndirectBox: Encodable where T: Encodable {
    func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}
