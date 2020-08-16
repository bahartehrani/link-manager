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
    
}
