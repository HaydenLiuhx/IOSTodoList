//
//  Todo.swift
//  TableView
//
//  Created by 刘皇逊 on 4/11/19.
//  Copyright © 2019 刘皇逊. All rights reserved.
//

import Foundation

//class Todo{
//    var name = ""
//    var checked = false
//    init(<#parameters#>) {
//        <#statements#>
//    }
//}


//struct 约等于class -- 不需要init, 是一种轻量级的class
struct Todo:Codable {
    var name = ""
    var checked = false
}
