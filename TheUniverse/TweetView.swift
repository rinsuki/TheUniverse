//
//  TweetView.swift
//  TweetView
//
//  Created by user on 2021/07/28.
//

import SwiftUI

struct TweetView: View {
    let tweet: T1Tweet
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: tweet.user.profileImageURL(size: "400x400")) {
                $0.resizable()
            } placeholder: {
                Color.gray
            }
                .frame(width: 48, height: 48)
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text(tweet.user.screenName).layoutPriority(1000)
                    Text(tweet.user.name).opacity(0.5).layoutPriority(999)
                }
                .lineLimit(1)
                Text(tweet.text)
                if let quoted = tweet.quotedStatus {
                    TweetView(tweet: quoted.value)
                }
            }
        }
        .font(Font.system(size: 13).bold())
    }
}

//struct TweetView_Previews: PreviewProvider {
//    static var previews: some View {
//        TweetView()
//    }
//}
