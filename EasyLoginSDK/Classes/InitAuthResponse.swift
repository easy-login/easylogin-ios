//
//  InitAuthResponse.swift
//  EasyLogin
//
//  Created by Vinh on 3/2/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation

@objcMembers
class InitAuthResponse: ServiceModel {
    var channel: Channel
    var state: String
    
    init(channel: Channel, state: String) {
        self.channel = channel
        self.state = state
        super.init()
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let state = try container.decode(String.self, forKey: .state)
        let channel = try container.decode(Channel.self, forKey: .channel)
        self.init(channel: channel, state: state)
    }
    
    enum CodingKeys: String, CodingKey {
        case channel
        case state
    }
    
}
