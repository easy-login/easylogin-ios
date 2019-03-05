//
//  ProviderAuthHandler.swift
//  EasyLogin
//
//  Created by Vinh on 3/2/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation
import LineSDK

protocol ProviderAuthHandler {
    func setEasyLogin(easyLogin: EasyLogin) throws
    
    func setAuthSession(authSession: AuthSession)
    
    func performAuthorize(channel: Channel)
    
    func getProviderName() -> String
    
    func logout()
}

class ProviderAuthHandlerFactory {
    static func create(provider: String) throws -> ProviderAuthHandler {
            switch provider {
            case "line":
                return LineAuthHandler()
            default:
                throw EasyLoginError.provider("Invalid provider")
            }
    }
}
