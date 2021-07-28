//
//  TwitterAPIEndpoint.swift
//  TwitterAPIEndpoint
//
//  Created by user on 2021/07/27.
//

import Foundation

protocol TwitterAPIEndpoint {
    associatedtype Response: Decodable
    
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var params: [String: String] { get }
}

extension OAuthSigner {
    func request<R: TwitterAPIEndpoint>(_ endpoint: R) async throws -> R.Response {
        let req = signedRequest(endpoint.method, url: URL(string: endpoint.endpoint)!, params: endpoint.params)
        let (data, res) = try await URLSession.shared.data(for: req)
        let decoded = try JSONDecoder().decode(R.Response.self, from: data)
        return decoded
    }
}
