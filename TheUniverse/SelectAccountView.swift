//
//  SelectAccountView.swift
//  SelectAccountView
//
//  Created by user on 2021/07/28.
//

import SwiftUI
import Combine

class SelectAccountViewModel: ObservableObject {
    @Published var accounts: [TwitterAccount] = []
    
    func reload() {
        accounts = Databases.Accounts.inDatabase { db in
            (try? TwitterAccount.all().fetchAll(db)) ?? []
        }
    }
}

struct SelectAccountView: View {
    @ObservedObject var viewModel = SelectAccountViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(viewModel.accounts) { account in
                        NavigationLink {
                            MainView(account: account)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(account.name)
                                Text(account.screenName).font(.footnote).foregroundColor(.secondary)
                            }
                        }

                    }
                }
                Section {
                    NavigationLink {
                        AddAccountView()
                    } label: {
                        Text("Add Account...")
                    }
                }
            }
            .navigationTitle(Text("Accounts"))
            .onAppear {
                viewModel.reload()
            }
        }
    }
}

struct SelectAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SelectAccountView()
    }
}
