//
//  EasyLoginImpl.swift
//  EasyLogin
//
//  Created by Vinh on 3/2/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation
import UIKit

@objcMembers
class EasyLoginImpl: EasyLogin {
    
    static let CALLBACK_URI = "ios://00001";
    
    let lock = NSLock()
    private var session: AuthSession?
    private var authHandler: ProviderAuthHandler?
    private var provider: String?
    private var authListener : ((Result<AuthResult, EasyLoginError>) -> Void)?

    func getAuthHandler() -> ProviderAuthHandler? {
        return self.authHandler
    }
    
    init() {
    }
    
    func setup(appId: String) {
        let config = EasyLoginConfig(appId: appId)
        EasyLoginConfig._shared = config
    }
    
    func authorize(provider: String, completionHandler completion: @escaping (Result<AuthResult, EasyLoginError>) -> Void) throws {
        lock.lock()
        defer { lock.unlock() }
        self.provider = provider
        self.authListener = completion
        if EasyLoginConfig.shared.appId.isEmpty {
            throw EasyLoginError.setup("AppId is not register. You need setup before login")
        }
        self.session = AuthSession(provider: provider, appId: EasyLoginConfig.shared.appId)
        API.shared.authorize(provider: provider, appId: EasyLoginConfig.shared.appId, callbackUri: EasyLoginImpl.CALLBACK_URI, codeChallenge: session?.codeVerifier?.hashed) { (response, error) in
            if error == nil, let response = response {
                self.session?.channel = response.channel
                self.session?.state = response.state
                do {
                    try self.createAuthHandler(provider: provider)
                } catch {
                    if let authListener = self.authListener {
                        authListener(.failure(EasyLoginError.provider(error.localizedDescription)))
                    }
                }
            } else {
                if let authListener = self.authListener {
                    authListener(.failure(EasyLoginError.login( error?.localizedDescription ?? "Login error")))
                }
            }
        }
    }
    
    internal func provideAuthSuccess(provider: String, result: AuthResult) {
        self.verifyAccessToken(provider: provider, accessToken: result.getAuthToken()?.authToken ?? "", state: self.session?.state ?? "")
        authListener?(.success(result))
    }
    
    internal func provideAuthFailure(provider: String, error: Error) {
        authListener?(.failure(EasyLoginError.provider(error.localizedDescription)))
    }
    
    func verifyAccessToken(provider: String, accessToken: String, state: String) {
        API.shared.verifyToken(provider: provider, accessToken: accessToken, state: state) { [weak self] (response, error) in
            guard let `self` = self else {
                return
            }
            if error == nil, let response = response {
                self.session?.authToken = response
            } else {
                self.session?.authToken = nil
            }
        }
    }
    
    private func createAuthHandler(provider: String) throws {
        authHandler = try? ProviderAuthHandlerFactory.create(provider: provider)
        try authHandler?.setEasyLogin(easyLogin: self)
        authHandler?.setAuthSession(authSession: self.session!)
        if let channel = self.session?.channel {
            authHandler?.performAuthorize(channel: channel);
        }
    }

}
