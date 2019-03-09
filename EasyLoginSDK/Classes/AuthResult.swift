//
//  AuthResult.swift
//  EasyLogin
//
//  Created by Vinh on 3/2/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation

public protocol AuthResult {
    func getResponseCode() -> Int
    
    func getAuthToken() -> EasyAuthToken?
    
    func getProviderAccessToken() -> ProviderAccessToken?
    
    func getProviderIdToken() -> ProviderIdToken?
    
    func isOpenIdSupport() -> Bool
    
    func getAuthorizedProfile(completionHandler completion: @escaping (Result<EasyProfile, EasyLoginError>) -> Void)
    
    func activateAuthorizedProfile(completionHandler completion: @escaping (Result<Bool, EasyLoginError>) -> Void)
}
