//
//  Channel.swift
//  EasyLogin
//
//  Created by Vinh on 3/2/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation

class Channel: ServiceModel {
    
    public init(clientId: String, scopes: [String], options: [String]) {
        self.clientId = clientId
        self.scopes = scopes
        self.options = options
        super.init()
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let clientId = try container.decode(String.self, forKey: .clientId)
        let scopes = try container.decode([String].self, forKey: .scopes)
        let options = try container.decode([String].self, forKey: .options)
        self.init(clientId: clientId, scopes: scopes, options: options)
    }
    
    
    var clientId: String?
    var scopes: [String]?
    var options: [String]?
    
    
    
    enum CodingKeys: String, CodingKey {
        case clientId = "client_id"
        case scopes = "scopes"
        case options = "options"
    }
}
