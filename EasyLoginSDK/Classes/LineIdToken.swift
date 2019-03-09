//
//  LineIdToken.swift
//  EasyLogin
//
//  Created by Vinh on 3/2/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation
import LineSDK

class LineIdToken: ProviderIdToken {
    
    func getIssuer() -> String {
        return ""
    }
    
    func getSubject() -> String {
        return ""
    }
    
    func getAudience() -> String? {
        return ""
    }
    
    func getExpiresAt() -> Date? {
        return nil
    }
    
    func getIssuedAt() -> Date? {
        return nil
    }
    
    func getProfileAttributes() -> [String: Any] {
        return [:]
    }
    
    func getTokenString() -> String {
        return ""
    }
}
