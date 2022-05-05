//
//  DataSource.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/4.
//

import Foundation
import SQLite



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
        } catch _ {
            
        }
    }

}
