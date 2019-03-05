//
//  EasyLoginError.swift
//  EasyLogin
//
//  Created by Vinh on 3/2/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation

public enum EasyLoginError: Error {
    case setup(String)
    case provider(String)
    case login(String)
    case getProfile(String)
    case unknown(String)
    case requestFailed(String)
}
