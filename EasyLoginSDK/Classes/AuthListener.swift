//
//  AuthListener.swift
//  EasyLogin
//
//  Created by Vinh on 3/2/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation

public protocol AuthListener: class {
    func onAuthSuccess(provider: String, result: AuthResult)
    
    func onAuthFailure(provider: String,  error: Error)
}
