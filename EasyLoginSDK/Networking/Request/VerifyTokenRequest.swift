//
//  VerifyTokenRequest.swift
//  EasyLogin
//
//  Created by Vinh on 3/3/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation

class VerifyTokenRequest: Request {
    var url: URL
    
    var method: HTTPMethod = .post
    
    var headers: [String : String]?
    
    var parameters: [String : String]?
    
    init(provider: String, accessToken: String, state: String?) {
        self.url = URL(string: Config.buildURLType(path: .verifyToken, provider))!
        parameters = [:]
        parameters?["access_token"] = accessToken
        if let state = state {
            parameters?["state"] = state
        }
    }
}
