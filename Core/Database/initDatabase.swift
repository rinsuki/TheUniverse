//
//  initDatabase.swift
//  Database
//
//  Created by user on 2021/07/28.
//

import Foundation
import GRDB

enum Databases {
    static let Accounts = try! initDatabase()
}

private func initDatabase() throws -> DatabaseQueue {
    let path = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).path
    print(path)
    let dbQueue = try DatabaseQueue(path: path + "/accounts.sqlite")
    
    var migrator = DatabaseMigrator()
    migrator.registerMigration("v1.accounts") { db in
        try db.create(table: "accounts") { t in
            t.column("id", .text).primaryKey()
            t.column("twitter_id", .integer).notNull()
            t.column("name", .text).notNull()
            t.column("screen_name", .text).notNull()
            t.column("profile_image_url_https", .text).notNull()
            t.column("token", .text).notNull()
        }
    }
    
    try migrator.migrate(dbQueue)
    
    return dbQueue
}
