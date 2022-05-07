//
//  FateCatDataHelper.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/6.
//
import Foundation
import SQLite

struct FateCatBreed{
    var id: String
    var breedName: String
    var times:Int
}

class FateCatBreedDataHelper {
    static let TABLE_NAME = "fate_breed"
   
    static let table = Table(TABLE_NAME)
    static let id = Expression<String>("id")
    static let breedName = Expression<String>("breedName")
    static let times = Expression<String>("times")


   
    static func createTable() throws {
        guard let DB = SQLiteDataSource.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        do {
            let _ = try DB.run( table.create(ifNotExists: true) {t in
                t.column(id, primaryKey: true)
                t.column(breedName)
                t.column(times)
                })
        } catch _ {
            // Error throw if table already exists
        }
       
    }
   
    static func insert(item: FateCatBreed) throws -> Int64 {
        guard let DB = SQLiteDataSource.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        if (item.id != nil && item.breedName != nil && item.times != nil ) {
            let insert = table.insert(id <- item.id, breedName <- item.breedName)
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
   
    static func delete (item: FateCatBreed) throws -> Void {
        guard let DB = SQLiteDataSource.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        let delId = item.id
        let query = table.filter(id == delId)
        do {
            let tmp = try DB.run(query.delete())
            guard tmp == 1 else {
                throw DataAccessError.Delete_Error
            }
        } catch _ {
            throw DataAccessError.Delete_Error
        }
        
    }
   
    //查找times最大的breed的breedNames
    static func findMaxTimesBreedName() throws -> String {
        guard let DB = SQLiteDataSource.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }

        let query=table.order(times.desc)
        var items = try! DB.prepare(query)
        for item in  items {
            return item[breedName]
        }
        return ""
    }
   
    //根据breedId返回FateBreed
    static func findFateBreedByBreedId(breedId: String) throws -> FateCatBreed? {
        guard let DB = SQLiteDataSource.sharedInstance.BBDB else {
            throw DataAccessError.Datastore_Connection_Error
        }
        let query = table.filter(id == breedId)
        var items = try! DB.prepare(query)
        for item in  items {
            return FateCatBreed(id: item[id] , breedName: item[breedName],times: Int(item[times])!)
        }
        return nil
    }
//    static func findAll() throws -> [FateCatBreed]? {
//        guard let DB = SQLiteDataSource.sharedInstance.BBDB else {
//            throw DataAccessError.Datastore_Connection_Error
//        }
//        var retArray : [FateCatBreed]=[]
//        var items = try! DB.prepare(table)
//        for item in items {
//            retArray.append(CollectedCatImage(id: item[id], url: item[url]))
//        }
//
//        return retArray
//    }
}
