//
//  LineAuthResult.swift
//  EasyLogin
//
//  Created by Vinh on 3/2/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation
import LineSDK

class LineAuthResult: AuthResult {
    
    var authSession: AuthSession?
    
    public func getResponseCode() -> Int {
        return 200
    }
    
    public func getAuthToken() -> EasyAuthToken? {
        return self.authSession?.authToken
    }
    
    //
    public func getAuthorizedProfile(completionHandler completion: @escaping (Result<EasyProfile, EasyLoginError>) -> Void) {
        if let token = self.authSession?.authToken?.authToken,
            let appId = authSession?.appId {
            let hash = CodeVerifierFactory.shared.code
            API.shared.getAuthorizedProfile(appId: appId, authToken: token, codeVerifier: hash) { (response, error) in
                if error == nil, let response = response {
                    completion(.success(response))
                } else {
                    completion(.failure(EasyLoginError.getProfile(error?.localizedDescription ?? "Can not get user profile")))
                }
            }
        } else {
            completion(.failure(EasyLoginError.getProfile("Token not found")))
        }
    }
    
    public func activateAuthorizedProfile(completionHandler completion: @escaping (Result<Bool, EasyLoginError>) -> Void){
        if let token = authSession?.authToken?.authToken, let appId = authSession?.appId {
            let hash = CodeVerifierFactory.shared.code
            API.shared.activateAuthorizedProfile(appId: appId, authToken: token, codeVerifier: hash) { (response, error) in
                if error == nil, let response = response {
                    completion(.success(response.success ?? false))
                } else {
                    completion(.failure(EasyLoginError.requestFailed(error?.localizedDescription ?? "Can not activite user profile")))
                }
            }
        } else {
            completion(.failure(EasyLoginError.getProfile("Token not found")))
        }
    }
    
    func getAuthSession() -> AuthSession? {
        return self.authSession
    }
    
    private var token: AccessToken
    
    init(token: AccessToken, authSession: AuthSession?) {
        self.token = token
        self.authSession = authSession
    }
    
     func getProviderAccessToken() -> ProviderAccessToken? {
        return LineAccessToken(accessToken: self.token)
    }
    
     func isOpenIdSupport() -> Bool {
        return true
    }
    
     func getProviderIdToken() -> ProviderIdToken? {
        return nil
    }
}
