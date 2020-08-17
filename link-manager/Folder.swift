//
//  Folder.swift
//  link-manager
//
//  Created by Productivity on 8/16/20.
//

import Foundation

struct Folder : Hashable {
    static func == (lhs: Folder, rhs: Folder) -> Bool {
        return lhs.name == rhs.name
    }
    
    var id = UUID()
    var name : String
    
    var links : [Link] = []
    
}

struct Link : Hashable {
    static func == (lhs: Link, rhs: Link) -> Bool {
        return lhs.link == rhs.link
    }
    
    var id = UUID()
    var name : String
    var link : String
    
}
