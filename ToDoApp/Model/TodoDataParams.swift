//
//  TodoDataParams.swift
//  ToDoApp
//
//  Created by kobayashi ikki on 2019/04/07.
//  Copyright © 2019 Ikki. All rights reserved.
//

import Foundation
import RealmSwift

//タスクの保存用
class  TodoDataParams : Object {
    @objc dynamic var id : Int = 0
    @objc dynamic var title : String = ""
    @objc dynamic var flag : Bool = false
}
