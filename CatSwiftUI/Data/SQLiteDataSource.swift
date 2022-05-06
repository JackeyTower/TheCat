//
//  DataSource.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/4.
//

import Foundation
import SQLite


//sqlite数据连接源
class SQLiteDataSource {
    static let sharedInstance = SQLiteDataSource()
    let BBDB: Connection?
   
    private init() {
       
        let path=NSHomeDirectory() + "/Documents" + "/db.sqlite3"
       
       
        do {
            BBDB = try Connection(path)
        } catch _ {
            BBDB = nil
        }
    }
   
    func createTables() throws{
        do {
            try CatImageDataHelper.createTable()
            try VoteCatImageDataHelper.createTable()
            try FateCatBreedDataHelper.createTable()
        } catch _ {
            
        }
    }

}
