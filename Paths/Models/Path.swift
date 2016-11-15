//
//  Path.swift
//  Paths
//
//  Created by Teodor on 13/11/2016.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

class Path {
    var id: Int
    var name: String
    var description: String
    var pois: Array<POI>?
    
    init(id: Int, name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
    }
}
