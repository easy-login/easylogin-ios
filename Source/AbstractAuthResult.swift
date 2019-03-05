//
//  AbstractAuthResult.swift
//  EasyLogin
//
//  Created by Vinh on 3/2/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation

class AbstractAuthResult: AuthResult {
    
    private var authSession: AuthSession?
    
    init(authSession: AuthSession?) {
        self.authSession = authSession
    }
    
    public func getResponseCode() -> Int {
        return 200
    }
    
    public func getAuthToken() -> EasyAuthToken? {
        return self.authSession?.authToken
    }
    
    //
    func getAuthorizedProfile(completionHandler completion: @escaping (Result<EasyProfile, EasyLoginError>) -> Void) {
        if let token = self.authSession?.authToken?.authToken, let hash = authSession?.codeVerifier?.hashed,
            let appId = authSession?.appId {
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
        if let token = authSession?.authToken?.authToken, let hash = authSession?.codeVerifier?.hashed, let appId = authSession?.appId {
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
    
    
}
