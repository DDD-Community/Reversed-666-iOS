//
//  BrandModel.swift
//  Bring
//
//  Created by cado.avo on 2021/09/23.
//  Copyright © 2021 com.666. All rights reserved.
//

import Foundation
import SwiftUI
import Network

// 임시로 만든 모델
enum ProductCategory: String, CaseIterable {
    case shoes = "Shoes"
    case accesary = "Accesary"
    case clothes = "Clothes"
    
}

struct Brand: DomainModel, Hashable, Identifiable {
    typealias ResponseType = BrandModelDTO
    
    var id: Int = -1
    var name: String = ""
    var subTitle: String = ""
    var brandLink: String = ""
    
    var imageName: String = ""
    var logoImage: String = ""
    var category: ProductCategory? = nil
    
    init() { }
    init(from response: ResponseType) {
        func convert(from category: BrandModelDTO.Category) -> ProductCategory {
            switch category {
                case .shoes:
                    return .shoes
                case .accesary:
                    return .accesary
                case .clothes:
                    return .clothes
            }
        }
        
        self.id = response.id ?? -1
        self.name = response.title ?? ""
        self.subTitle = response.subTitle ?? ""
        self.brandLink = response.brandLink ?? ""
        self.imageName = response.imageName ?? ""
        self.logoImage = response.logoImage ?? ""
        if let category = response.category {
            self.category = convert(from: category)
        }
    }
}
