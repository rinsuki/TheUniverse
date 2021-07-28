//
//  TimelineView.swift
//  TimelineView
//
//  Created by user on 2021/07/28.
//

import UIKit
import SwiftUI
import Introspect

struct TimelineView: View {
    let account: TwitterAccount
    @State var tweets: [T1Tweet] = []
    
    var body: some View {
        List(tweets) { tweet in
            TweetView(tweet: tweet)
            .listRowInsets(.init(top: 8, leading: 8, bottom: 8, trailing: 8))
            .introspectTableViewCell { cell in
                cell.layoutMargins = .zero
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .listStyle(.plain)
        .introspectTableView { tableView in
            tableView.layoutMargins = .zero
        }
        .navigationTitle(Text("Home Timeline"))
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity)
        .task {
            do {
                let tweets = try await account.accessToken.signer.request(HomeTimeline())
                withAnimation {
                    self.tweets = tweets
                }
            } catch {
                print(error)
                print("?")
            }
        }
        .refreshable {
            guard let sinceId = tweets.first?.id else {
                return
            }
            do {
                let tweets = try await account.accessToken.signer.request(HomeTimeline(sinceID: sinceId))
                withAnimation {
                    self.tweets.insert(contentsOf: tweets, at: 0)
                }
            } catch {
                print(error)
                print("?")
            }
        }
    }
}

//struct TimelineView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimelineView(account)
//    }
//}
