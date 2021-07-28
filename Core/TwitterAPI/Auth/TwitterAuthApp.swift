//
//  TwitterAuthApp.swift
//  TwiLive
//
//  Created by user on 2019/09/14.
//  Copyright © 2019 rinsuki. All rights reserved.
//

import Foundation

struct TwitterAuthApp: Codable {
    static let iphone = TwitterAuthApp(appKey: "IQKbtAYlXLripLGPWd0HUA", appSecret: "GgDYlkSvaPxGxC4X8liwpUoqKwwr3lCADbz8A7ADU")

    var appKey: String
    var appSecret: String
    
    func getRequestToken() -> URLRequest {
        return OAuthSigner(consumerKey: appKey, consumerSecret: appSecret).signedRequest(
            .post, url: URL(string: "https://api.twitter.com/oauth/request_token")!,
            params: ["oauth_callback": "oob"]
        )
    }
    
    func xauth(userName: String, password: String) -> URLRequest {
        return OAuthSigner(consumerKey: appKey, consumerSecret: appSecret).signedRequest(
            .post, url: URL(string: "https://api.twitter.com/oauth/access_token")!,
            params: ["x_auth_username": userName, "x_auth_password": password, "x_auth_mode": "client_auth"]
        )
    }
}
