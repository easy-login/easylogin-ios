//
//  ActivateAuthorizedResponse.swift
//  EasyLogin
//
//  Created by Vinh on 3/2/19.
//  Copyright © 2019 Vinh. All rights reserved.
//

import Foundation

class ActivateAuthorizedResponse: ServiceModel {
    
    var success: Bool?
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init()
        self.success = try container.decode(Bool.self, forKey: .success)
    }
    
    enum CodingKeys: String, CodingKey {
        case success
    }
}
