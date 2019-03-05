//
//  EasyLogin.swift
//  EasyLogin
//
//  Created by Vinh on 3/2/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation
import UIKit
import LineSDK

public protocol EasyLogin {
    func authorize(provider: String, completionHandler completion: @escaping (Result<AuthResult, EasyLoginError>) -> Void) throws
    
    func setup(appId: String)

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool
}

extension EasyLogin {
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        if (getAuthHandler() is LineAuthHandler) {
            return LoginManager.shared.application(app, open: url, options: options)
        } else {
            return false
        }
    }
    
    func getAuthHandler() -> ProviderAuthHandler? {
        if self is EasyLoginImpl {
            return (self as! EasyLoginImpl).getAuthHandler()
        }
        return nil
    }
}

@objcMembers
public class EasyLoginFactory {
    private static var instance: EasyLogin?
    public static var shared: EasyLogin {
        get {
            if instance == nil {
                instance = EasyLoginImpl()
            }
            return instance!
        }
    }
}
