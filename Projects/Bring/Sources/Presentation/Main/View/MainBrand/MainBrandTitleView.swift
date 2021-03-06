//
//  MainBrandTitleView.swift
//  Bring
//
//  Created by devming on 2021/10/21.
//  Copyright © 2021 com.666. All rights reserved.
//

import SwiftUI
import Network

struct MainBrandTitleView: View {
    var delegate: MainEventDelegate?
    @State var brand: Brand
    var body: some View {
        HStack(alignment: .center) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(brand.engName)
//                        .font(BringFontStyle.brandL.font)
                        .font(Font.system(size: 40, weight: .bold, design: .default))
                        .lineLimit(2)
//                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text(brand.name)
                        .font(BringFontStyle.textL.font)
                        .lineLimit(1)
                }
                Spacer()
            }
            VStack {
                HStack(alignment: .top) {
                    Button {
                        delegate?.callLike(id: brand.id) {
                            brand.isLiked.toggle()
                        }
                    } label: {
                        Image(brand.isLiked ? "icHeartFill" : "icHeartLine")
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .center)
                            .scaledToFit()
                            .clipped()
                            .padding(10)
                    }
                    ZStack {
                        Image("icArrowRightFill")
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .center)
                            .scaledToFit()
                            .padding(10)
                            .background(.clear)
                    }
                }
                Spacer()
            }
        }
    }
}

struct MainBrandTitleView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MainViewModel(serviceManager: BrandServiceManagerMock())
        MainBrandTitleView(brand: viewModel.mainBrands.first!)
            .frame(width: .infinity, height: .infinity, alignment: .center)
    }
}
