//
//  BrandLikeRequest.swift
//  Network
//
//  Created by devming on 2021/11/25.
//  Copyright © 2021 com.666. All rights reserved.
//

import Foundation

public struct BrandLikeRequest: Encodable {
    
    var brand: Int
    
    init(id: Int) {
        brand = id
    }
}
