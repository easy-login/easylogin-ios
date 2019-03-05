//
//  EasyAuthToken.swift
//  EasyLogin
//
//  Created by Vinh on 3/2/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation

public class EasyAuthToken: ServiceModel {
    public var authToken: String?
    public var expireAt: Date?
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init()
        self.authToken = try container.decode(String.self, forKey: .authToken)
        self.expireAt = try container.decode(String.self, forKey: .expireAt).toDate()
    }
    
    enum CodingKeys: String, CodingKey {
        case authToken = "auth_token"
        case expireAt = "expire_at"
    }
}
