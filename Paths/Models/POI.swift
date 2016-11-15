//
//  POI.swift
//  Paths
//
//  Created by Teodor on 13/11/2016.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

class POI {
    var id: Int
    var name: String
    var latitude: Float
    var longitude: Float
    
    init(id: Int, name: String, latitude: Float, longitude: Float) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
