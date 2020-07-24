//
//  User.swift
//  TableView
//
//  Created by 刘皇逊 on 6/11/19.
//  Copyright © 2019 刘皇逊. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
}
