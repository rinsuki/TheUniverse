//
//  ActivitiesView.swift
//  ActivitiesView
//
//  Created by user on 2021/07/29.
//

import SwiftUI

struct ActivitiesView: View {
    let account: TwitterAccount
    let type: ActivityRequest.ActivityType
    @State var activities: [T1Activity] = []
    
    var body: some View {
        List(activities) { activity in
            ActivityView(activity: activity)
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
        .navigationTitle(Text("Activities"))
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity)
        .task {
            do {
                let activities = try await account.accessToken.signer.request(ActivityRequest(type: type))
                withAnimation {
                    self.activities = activities
                }
            } catch {
                print(error)
                print("?")
            }
        }
    }
}
