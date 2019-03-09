//
//  AuthSession.swift
//  EasyLogin
//
//  Created by Vinh on 3/2/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation

class AuthSession {
    
    init(provider: String, appId: String) {
        self.provider = provider
        self.authStatus = AuthStatus.unknown.rawValue
        self.appId = appId
    }
    
    var appId: String
    var provider: String
    var channel: Channel?
    var state: String?
    var authStatus: String?
    var authToken: EasyAuthToken?
}

enum AuthStatus: String {
    case unknown = "unknown"
    case authorized = "authorized"
    case waitReg = "wait_reg"
    case failed = "failed"
    case succeeded = "succeeded"
}
