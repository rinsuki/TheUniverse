//
//  AddAccountView.swift
//  TheUniverse
//
//  Created by user on 2021/07/27.
//

import SwiftUI

struct AddAccountView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var userName: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error: String? = nil
    
    var body: some View {
        Form {
            Section {
                TextField("Screen Name", text: $userName)
                SecureField("Password", text: $password)
            }
            .disabled(loading)
            Button {
                print("signin...")
                let app = TwitterAuthApp.iphone
                let req = app.xauth(userName: userName, password: password)
                loading = true
                Task {
                    let (data, _) = try await URLSession.shared.data(for: req)
                    let str = String(data: data, encoding: .utf8)!
                    let params = str.parseQueryParameters()
                    guard
                        let token = params["oauth_token"], let tokenSecret = params["oauth_token_secret"]
                    else {
                        self.error = str
                        return
                    }
                    let accessToken = TwitterAuthAccessToken(app: app, token: token, tokenSecret: tokenSecret)
                    let req = accessToken.signer.signedRequest(.get, url: URL(string: "https://api.twitter.com/1.1/account/verify_credentials.json")!, params: [:])
                    let (vd, _) = try await URLSession.shared.data(for: req)
                    let decoder = JSONDecoder()
                    let user = try decoder.decode(T1User.self, from: vd)
                    var account = TwitterAccount(
                        twitterID: user.id, name: user.name, screenName: user.screenName, profileImageURLHTTPS: user.profileImageURLHTTPS,
                        accessToken: accessToken
                    )
                    try Databases.Accounts.inDatabase { db in
                        try account.save(db)
                    }
                    dismiss.callAsFunction()
                }
            } label: {
                HStack(alignment: .center) {
                    Text("Sign In")
                    Spacer()
                    if loading {
                        ProgressView().progressViewStyle(CircularProgressViewStyle())
                    }
                }
            }
            .disabled(userName.count < 1 || password.count < 1 || loading)
        }
        .alert(isPresented: .init(get: { error != nil }, set: { if $0 { error = "?" } else { error = nil } })) {
            Alert(title: Text("Alert"), message: Text(error ?? "(nil)"))
        }
        .navigationTitle(Text("Add Account"))
        .navigationBarBackButtonHidden(loading)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AddAccountView()
    }
}
