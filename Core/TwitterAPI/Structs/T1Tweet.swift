//
//  T1Tweet.swift
//  Tweet
//
//  Created by user on 2021/07/27.
//

import Foundation

struct T1Tweet: Codable, Identifiable {
    typealias ID = UInt64
    
    var id: ID
    var text: String
    var user: T1User

    var inReplyToStatusID: ID?
    
    var quotedStatusID: ID?
    var quotedStatus: IndirectBox<T1Tweet>?

    var selfThread: SelfThread?
    struct SelfThread: Codable {
        var id: ID
    }

    enum CodingKeys: String, CodingKey {
        case id, user
        case text = "full_text"
        case inReplyToStatusID = "in_reply_to_status_id"
        case quotedStatusID = "quoted_status_id"
        case quotedStatus = "quoted_status"
        case selfThread = "self_thread"
    }
}
