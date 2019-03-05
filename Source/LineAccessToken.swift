//
//  LineAccessToken.swift
//  EasyLogin
//
//  Created by Vinh on 3/2/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation
import LineSDK

class LineAccessToken: ProviderAccessToken {
    
    var token: AccessToken
    
    init(accessToken: AccessToken) {
        self.token = accessToken
    }
    
    func getTokenString() -> String {
        return self.token.value
    }
    
    func getExpiresInMillis() -> Date {
        return self.token.expiresAt
    }
}
