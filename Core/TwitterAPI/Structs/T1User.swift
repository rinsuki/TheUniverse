//
//  T1User.swift
//  TheUniverse
//
//  Created by user on 2021/07/27.
//

import Foundation

struct T1User: Codable, Identifiable {
    typealias ID = UInt64
    var id: ID
    
    var name: String
    var screenName: String
    var protected: Bool
    
    var profileImageURLHTTPS: URL
    
    func profileImageURL(size: String) -> URL {
        return URL(string: profileImageURLHTTPS.absoluteString.replacingOccurrences(of: "_normal", with: "_" + size))!
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, protected
        case screenName = "screen_name"
        case profileImageURLHTTPS = "profile_image_url_https"
    }
}
