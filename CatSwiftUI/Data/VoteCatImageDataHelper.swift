//
//  VoteCatImageDataHelper.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/6.
//

import Foundation
import SQLite

struct VotedCatImage{
    var id: String
    var url: String
}

class VoteCatImageDataHelper {
    static let TABLE_NAME = "vote_cat_image"
   
    static let table = Table(TABLE_NAME)
    static let id = Expression<String>("id")
    static let url = Expression<String>("url")


   
    static func createTable() throws {
        guard let DB = SQLiteDataSource.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        do {
            let _ = try DB.run( table.create(ifNotExists: true) {t in
                t.column(id, primaryKey: true)
                t.column(url)
                })
        } catch _ {
            // Error throw if table already exists
        }
       
    }
   
    static func insert(item: VotedCatImage) throws -> Int64 {
        guard let DB = SQLiteDataSource.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        if (item.id != nil && item.url != nil ) {
            let insert = table.insert(id <- item.id, url <- item.url)
            do {
                let rowId = try DB.run(insert)
                guard rowId > 0 else {
                    throw DataAccessError.Insert_Error
                }
                return rowId
            } catch _ {
                
            }
        }
        throw DataAccessError.Nil_In_Data
    }
   
//    static func delete (item: T) throws -> Void {
//        guard let DB = SQLiteDataStore.sharedInstance.BBDB else {
//            throw DataAccessError.Datastore_Connection_Error
//        }
//        if let id = item.teamId {
//            let query = table.filter(teamId == id)
//            do {
//                let tmp = try DB.run(query.delete())
//                guard tmp == 1 else {
//                    throw DataAccessError.Delete_Error
//                }
//            } catch _ {
//                throw DataAccessError.Delete_Error
//            }
//        }
//    }
   
    static func find(findId: String) throws -> VotedCatImage? {
        guard let DB = SQLiteDataSource.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        let query = table.filter(id == findId)
        var items = try! DB.prepare(query)
        for item in  items {
            return VotedCatImage(id: item[id] , url: item[url])
        }
        return nil
    }
   
    static func findAll() throws -> [VotedCatImage]? {
        guard let DB = SQLiteDataSource.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        var retArray : [VotedCatImage]=[]
        var items = try! DB.prepare(table)
        for item in items {
            retArray.append(VotedCatImage(id: item[id], url: item[url]))
        }
       
        return retArray
    }
}
