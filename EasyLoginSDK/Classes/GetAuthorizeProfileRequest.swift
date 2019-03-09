//
//  GetAuthorizeProfileRequest.swift
//  EasyLogin
//
//  Created by Vinh on 3/3/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation

class GetAuthorizeProfileRequest: Request {
    var url: URL
    
    var method: HTTPMethod = .post
    
    var headers: [String : String]?
    
    var parameters: [String : String]?
    
    init(appId: String, authToken: String, codeVerifier: String) {
        self.url = URL(string: Config.buildURLType(path: .getAuthorizedProfile))!
        parameters = [:]
        parameters?["auth_token"] = authToken
        parameters?["code_verifier"] = codeVerifier
    }
}
