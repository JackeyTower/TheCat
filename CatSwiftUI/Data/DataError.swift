//
//  DataError.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/4.
//

enum DataAccessError: Error {
    case Datastore_Connection_Error
    case Insert_Error
    case Delete_Error
    case Search_Error
    case Nil_In_Data
}
