//
//  EasyProfile.swift
//  EasyLogin
//
//  Created by Vinh on 3/2/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation

public class EasyProfile: ServiceModel {
    public var createdAt: Date?
    public var lastAuthorizedAt: Date?
    public var linkedAt: Date?
    public var loginCount: Int?
    public var provider: String?
    public var socialId: Int?
    public var userId: String?
    public var attrs: [String: String] = [:]
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init()
        self.createdAt = try container.decode(String.self, forKey: .createdAt).toDate()
        self.lastAuthorizedAt = try container.decode(String.self, forKey: .lastAuthorizedAt).toDate()
        self.linkedAt = try container.decode(String.self, forKey: .linkedAt).toDate()
        self.loginCount = try container.decode(Int.self, forKey: .loginCount)
        self.provider = try container.decode(String.self, forKey: .provider)
        self.socialId = try container.decode(Int.self, forKey: .socialId)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.attrs = try container.decode([String: String].self, forKey: .attrs)
    }
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case lastAuthorizedAt = "last_authorized_at"
        case linkedAt = "linked_at"
        case loginCount = "login_count"
        case provider = "provider"
        case socialId = "social_id"
        case userId = "user_id"
        case attrs = "attrs"
    }
}
