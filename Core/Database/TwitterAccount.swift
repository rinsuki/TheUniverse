//
//  TwitterAccount.swift
//  TwitterAccount
//
//  Created by user on 2021/07/28.
//

import Foundation
import GRDB
import KeychainAccess

private let accountTokenKeychain = Keychain(service: "net.rinsuki.apps.TheUniverse.access-token").accessibility(.whenUnlocked)

private var accessTokenObjects: [String: TwitterAuthAccessToken] = [:]

public struct TwitterAccount: Codable, MutablePersistableRecord, FetchableRecord, Identifiable {
    init(twitterID: UInt64, name: String, screenName: String, profileImageURLHTTPS: URL, accessToken: TwitterAuthAccessToken) {
        self.id = UUID()
        self.twitterID = twitterID
        self.name = name
        self.screenName = screenName
        self.profileImageURLHTTPS = profileImageURLHTTPS
        self.token = accessToken.token
        self.accessToken = accessToken
    }
    
    public static let databaseTableName = "accounts"
    
    public let id: UUID
    public let twitterID: UInt64
    public var name: String
    public var screenName: String
    public var profileImageURLHTTPS: URL
    public var token: String

    var accessToken: TwitterAuthAccessToken {
        get {
            if let at = accessTokenObjects[token] {
                return at
            } else {
                let data = try! accountTokenKeychain.getData(token)!
                let at = try! JSONDecoder().decode(TwitterAuthAccessToken.self, from: data)
                accessTokenObjects[token] = at
                return at
            }
        }
        
        set {
            token = newValue.token
            accessTokenObjects[token] = newValue
            let data = try! JSONEncoder().encode(newValue)
            try! accountTokenKeychain.set(data, key: token)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, token
        case twitterID = "twitter_id"
        case screenName = "screen_name"
        case profileImageURLHTTPS = "profile_image_url_https"
    }
}
