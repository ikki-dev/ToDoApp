//
//  RealmManager.swift
//  ToDoApp
//
//  Created by kobayashi ikki on 2019/04/07.
//  Copyright © 2019 Ikki. All rights reserved.
//

import Foundation
import Realm
import RealmSwift


class RealmManager : NSObject {
    
    //初期化
    let realm:Realm = try! Realm()
    
    /*TestDataParamsに関するメソッド*/
    // TestDataParamsの書き込み用メソッド
    func saveTodoDataParams(_ object: TodoDataParams )
    {
        try! realm.write {
            realm.add( object )
        }
    }
    //TestDataParamsの値を取得するための関数
    func getTodoDataParams() -> Results<TodoDataParams> {
        let objects = realm.objects( TodoDataParams.self)
        return objects
    }
    //TestDataParamsの特定のobjectを削除する用のメソッド
    func deleteSingleTodoDataParams( _ object: TodoDataParams  ){
        try! realm.write {
            let realmData = object
            realm.delete( realmData )
        }
    }
    //TestDataParamsの特定のobjectを追加する用のメソッド
    func addSingleTodoDataParams( _ object: TodoDataParams  ){
        try! realm.write {
            let realmData = object
            realm.add( realmData )
        }
    }
    //TestDataParamsのflagの値をtrueへ変更する用のメソッド
    func changeFlagTrueTodoDataParams( _ object: TodoDataParams  ){
        try! realm.write {
            let realmData = object
            realmData.flag = true
        }
    }
    //TestDataParamsのflagの値をfalseへ変更する用のメソッド
    func changeFlagFalseTodoDataParams( _ object: TodoDataParams  ){
        try! realm.write {
            let realmData = object
            realmData.flag = false
        }
    }
    //TestDataParamsの全件削除用のメソッド
    func deleteTodoDataParams(){
        try! realm.write {
            let realmData = realm.objects( TodoDataParams.self )
            realm.delete( realmData )
        }
    }
}
