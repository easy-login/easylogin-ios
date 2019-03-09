//
//  ProviderAccessToken.swift
//  EasyLogin
//
//  Created by Vinh on 3/2/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation

public protocol ProviderAccessToken {
    func getTokenString() -> String
    
    func getExpiresInMillis() -> Date
}
