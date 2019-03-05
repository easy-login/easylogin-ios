//
//  LineAuthHandler.swift
//  EasyLogin
//
//  Created by Vinh on 3/2/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation
import LineSDK

class LineAuthHandler: AbstractAuthHandler {
    
    override func performAuthorize(channel: Channel) {
        if let channelId = channel.clientId, let scopes = channel.scopes {
            let options: LoginManagerOptions = scopes.contains("add_friend") ? LoginManagerOptions.botPromptAggressive : []
            LoginManager.shared.setup(channelID: channelId, universalLinkURL: nil)
            LoginManager.shared.login(permissions: [.profile, .friends, .groups, .messageWrite, .openID], in: nil, options: options) { [weak self] (result) in
                guard let `self` = self else {
                    return
                }
                switch result {
                case let .success(success):
                    let apiResult = LineAuthResult(authResult: success, authSession: self.getAuthSession())
                    self.getEasyLoginAuth()?.provideAuthSuccess(provider: self.getProviderName(), result: apiResult)
                    break
                case let .failure(failure):
                    self.getEasyLoginAuth()?.provideAuthFailure(provider: self.getProviderName(), error: failure)
                    break
                }
            }
        }
    }
    
    override func getProviderName() -> String {
        return "line"
    }
}
