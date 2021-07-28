//
//  MainView.swift
//  MainView
//
//  Created by user on 2021/07/29.
//

import SwiftUI

struct MainView: View {
    let account: TwitterAccount
    
    var body: some View {
        List {
            NavigationLink {
                TimelineView(account: account)
            } label: {
                Text("Home Timeline")
            }
            Section("Activities") {
                NavigationLink {
                    ActivitiesView(account: account, type: .aboutMe)
                } label: {
                    Text("About Me (a.k.a. Notifications)")
                }
                // activity/by_friends.json only works with Tweetdeck token, otherwise returns empty array
//                NavigationLink {
//                    ActivitiesView(account: account, type: .byFriends)
//                } label: {
//                    Text("by Friends")
//                }
            }
        }
    }
}

