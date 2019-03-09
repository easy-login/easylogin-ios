//
//  Config.swift
//  EasyLogin
//
//  Created by Vinh on 3/2/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation

class Config: NSObject {
    
    static let BASE_URL = "https://api.easy-login.jp"
    
    enum Path: String {
        case authorize = "/auth/%@?platform=and"
        case verifyToken = "/auth/%@/verify-token"
        case getAuthorizedProfile = "/auth/profiles/authorized"
        case activateProfile = "/auth/profiles/activate"
    }
    
    static func buildURLType(path: Path, _ query: String) -> String {
        let url = BASE_URL + path.rawValue
        return String(format: url, query)
    }
    
    static func buildURLType(path: Path) -> String {
        let url = BASE_URL + path.rawValue
        return url
    }
}
