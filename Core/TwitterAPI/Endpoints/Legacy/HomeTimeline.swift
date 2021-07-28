//
//  HomeTimeline.swift
//  HomeTimeline
//
//  Created by user on 2021/07/29.
//

import Foundation

struct HomeTimeline: TwitterAPIEndpoint {
    typealias Response = [T1Tweet]
    
    let endpoint: String = "https://api.twitter.com/1.1/statuses/home_timeline.json"
    let method: HTTPMethod = .get
    var params: [String : String] {
        return [
            "since_id": sinceID?.description,
            "tweet_mode": "extended",
        ].compactMapValues({ $0 })
    }
    
    var sinceID: T1Tweet.ID? = nil
}
