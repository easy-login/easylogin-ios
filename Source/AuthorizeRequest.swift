//
//  AuthorizeRequest.swift
//  EasyLogin
//
//  Created by Vinh on 3/3/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation

class AuthorizeRequest: Request {
    var url: URL
    
    var method: HTTPMethod = .get
    
    var headers: [String : String]?
    
    var parameters: [String : String]?
    
    init(provider: String, appId: String,
         callbackUri: String?,
         codeChallenge: String?) {
        self.url = URL(string: Config.buildURLType(path: .authorize, provider))!
        parameters = [:]
        parameters?["platform"] = "ios"
        parameters?["app_id"] = appId
        if let callbackUri = callbackUri {
            parameters?["callback_uri"] = callbackUri
        }
        if let codeChallenge = codeChallenge {
            parameters?["code_challenge"] = codeChallenge
        }
    }
    
    
}
