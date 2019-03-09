//
//  ProviderIdToken.swift
//  EasyLogin
//
//  Created by Vinh on 3/2/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation

public protocol ProviderIdToken {
    func getIssuer() -> String
    
    func getSubject() -> String
    
    func getAudience() -> String?
    
    func getExpiresAt() -> Date?
    
    func getIssuedAt() -> Date?
    
    func getProfileAttributes() -> [String: Any]
    
    func getTokenString() -> String
}
