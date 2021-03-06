//
//  MainDetailView.swift
//  Bring
//
//  Created by devming on 2021/11/04.
//  Copyright © 2021 com.666. All rights reserved.
//

import SwiftUI

struct MainDetailView: View {
    
    var url: String
    var title: String?
    var presentedAsModal: Binding<Bool>
    
    enum Tab {
        case main
        case bookmark
        case my
    }
    
    init(url: String, title: String? = nil, presentedAsModal: Binding<Bool>) {
        self.url = url
        self.title = title
        self.presentedAsModal = presentedAsModal
    }
    
    var body: some View {
        VStack {
            BringWebView(url: url,
                         title: title,
                         presentedAsModal: presentedAsModal)
        }
    }
}

struct MainDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MainDetailView(url: "https://www.naver.com", presentedAsModal: .constant(true))
    }
}
