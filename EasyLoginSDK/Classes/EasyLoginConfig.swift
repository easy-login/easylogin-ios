//
//  EasyLoginConfig.swift
//  TestSDK
//
//  Created by Vinh on 3/4/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation

public struct EasyLoginConfig {
    
    static var _shared: EasyLoginConfig?
    static var shared: EasyLoginConfig {
        return guardSharedProperty(_shared)
    }
    
    let appId: String
    
    
    init(appId: String) {
        self.appId = appId
    }
}

func guardSharedProperty<T>(_ t: T?) -> T {
    guard let t = t else {
        Swift.fatalError("Use \(T.self) before setup. " +
            "Please call `EasyLogin.setup` before you do any other things in EasyLoginSDK.")
    }
    return t
}
