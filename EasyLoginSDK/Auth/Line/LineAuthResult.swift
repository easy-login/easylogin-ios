//
//  LineAuthResult.swift
//  EasyLogin
//
//  Created by Vinh on 3/2/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation
import LineSDK

class LineAuthResult: AbstractAuthResult {
    private var authResult: LoginResult
    
    init(authResult: LoginResult, authSession: AuthSession?) {
        self.authResult = authResult
        super.init(authSession: authSession)
    }
    
    func getProviderAccessToken() -> ProviderAccessToken? {
        return LineAccessToken(accessToken: self.authResult.accessToken)
    }
    
    func isOpenIdSupport() -> Bool {
        return true
    }
    
    func getProviderIdToken() -> ProviderIdToken? {
        return nil
    }
}
