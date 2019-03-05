//
//  AbstractAuthHandler.swift
//  EasyLogin
//
//  Created by Vinh on 3/2/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation

class AbstractAuthHandler: ProviderAuthHandler {
    func performAuthorize(channel: Channel) {
        
    }
    
    func getProviderName() -> String {
        return ""
    }
    
    func logout() {
        
    }
    
    
    private var easyLoginAuth: EasyLoginImpl?
    private var authSession: AuthSession?
    
    func setEasyLogin(easyLogin: EasyLogin) throws {
        if (!(easyLogin is EasyLoginImpl)) {
            throw EasyLoginError.provider("Unexpected EasyLogin," +
                " please use the provided Factory to create the instance")
        }
        self.easyLoginAuth = easyLogin as? EasyLoginImpl
    }
    
    func setAuthSession(authSession: AuthSession) {
        self.authSession = authSession
    }
    
    func getAuthSession() -> AuthSession? {
        return self.authSession
    }
    
    func getEasyLoginAuth() -> EasyLoginImpl? {
        return self.easyLoginAuth
    }
}
