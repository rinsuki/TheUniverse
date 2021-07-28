//
//  ActivityView.swift
//  ActivityView
//
//  Created by user on 2021/07/29.
//

import SwiftUI

// TODO: more better design
private struct TweetReactView: View {
    let imageSystemName: String
    let imageColor: Color
    let users: [T1User]
    let tweets: [T1Tweet]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Image(systemName: imageSystemName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48)
                    .frame(maxHeight: 48)
                    .foregroundColor(imageColor)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(users) { user in
                            AsyncImage(url: user.profileImageURL(size: "400x400")) {
                                $0.resizable()
                            } placeholder: {
                                Color.gray
                            }.frame(width: 48, height: 48)
                        }
                    }
                }.frame(height: 48)
            }
            ForEach(tweets) { tweet in
                TweetView(tweet: tweet)
            }
        }
    }
}

struct ActivityView: View {
    let activity: T1Activity
    
    var body: some View {
        Group {
            switch activity {
            case .favorite(base: _, users: let users, tweets: let tweets):
                TweetReactView(imageSystemName: "star.fill", imageColor: .yellow, users: users, tweets: tweets)
            case .mention(base: let base, tweets: let tweets):
                ForEach(tweets) { tweet in
                    TweetView(tweet: tweet)
                }
            case .reply(base: let base, tweets: let tweets):
                ForEach(tweets) { tweet in
                    TweetView(tweet: tweet)
                }
            case .retweet(base: let base, users: let users, tweets: let tweets):
                TweetReactView(imageSystemName: "repeat", imageColor: .green, users: users, tweets: tweets)
            case .notSupported(base: let base):
                Text("Not Supported Action: \(base.action)")
            }
        }
    }
}
