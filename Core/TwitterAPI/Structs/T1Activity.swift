//
//  T1Activity.swift
//  T1Activity
//
//  Created by user on 2021/07/29.
//

import Foundation

struct T1ActivityBase: Codable {
    var action: String
    var max_position: String
    var min_position: String
}

enum T1Activity: Decodable {
    case favorite(base: T1ActivityBase, users: [T1User], tweets: [T1Tweet])
    case mention(base: T1ActivityBase, tweets: [T1Tweet])
    case reply(base: T1ActivityBase, tweets: [T1Tweet])
    case retweet(base: T1ActivityBase, users: [T1User], tweets: [T1Tweet])
    case notSupported(base: T1ActivityBase)

    init(from decoder: Decoder) throws {
        let base = try T1ActivityBase(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        switch base.action {
        case "favorite":
            self = .favorite(
                base: base,
                users: try container.decode([T1User].self, forKey: .sources),
                tweets: try container.decode([T1Tweet].self, forKey: .targets)
            )
        case "mention":
            self = .mention(base: base, tweets: try container.decode([T1Tweet].self, forKey: .target_objects))
        case "reply":
            self = .reply(base: base, tweets: try container.decode([T1Tweet].self, forKey: .targets))
        case "retweet":
            self = .retweet(
                base: base,
                users: try container.decode([T1User].self, forKey: .sources),
                tweets: try container.decode([T1Tweet].self, forKey: .target_objects)
            )
        default:
            self = .notSupported(base: base)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case targets
        case sources
        case target_objects
    }
}

extension T1Activity: Identifiable {
    var base: T1ActivityBase {
        switch self {
        case .favorite(base: let base, users: _, tweets: _):
            return base
        case .mention(base: let base, tweets: _):
            return base
        case .reply(base: let base, tweets: _):
            return base
        case .retweet(base: let base, users: _, tweets: _):
            return base
        case .notSupported(base: let base):
            return base
        }
    }
    
    var id: String {
        return base.max_position + "-" + base.min_position
    }
}
