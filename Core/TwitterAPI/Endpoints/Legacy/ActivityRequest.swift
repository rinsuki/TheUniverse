//
//  ActivityRequest.swift
//  ActivityRequest
//
//  Created by user on 2021/07/29.
//

import Foundation

struct ActivityRequest: TwitterAPIEndpoint {
    typealias Response = [T1Activity]
    
    enum ActivityType {
        case aboutMe
        case byFriends
    }
    
    let type: ActivityType
    
    var endpoint: String {
        switch type {
        case .aboutMe:
            return "https://api.twitter.com/1.1/activity/about_me.json"
        case .byFriends:
            return "https://api.twitter.com/1.1/activity/by_friends.json"
        }
    }
    
    let method: HTTPMethod = .get
    var params: [String : String] {
        return [
            "tweet_mode": "extended",
            "model_version": "7",
            "count": "60",
//            "skip_aggregation": "true",
        ]
    }
}
