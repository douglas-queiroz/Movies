//
//  Movie.swift
//  MoviesApp
//
//  Created by Douglas Queiroz on 15/02/17.
//  Copyright © 2017 Douglas Queiroz. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import Realm

class Movie: Object, Mappable {
    dynamic var serverId: String?
    dynamic var title: String?
    dynamic var year: String?
    dynamic var type: String?
    dynamic var urlPoster: String?
    
    required init?(map: Map) {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init() {
        super.init()
    }
    
    func mapping(map: Map) {
        serverId <- map["imdbID"]
        title <- map["Title"]
        year <- map["Year"]
        type <- map["Type"]
        urlPoster <- map["Poster"]
    }
}
