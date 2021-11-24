//
//  BringTabView.swift
//  Bring
//
//  Created by cado.avo on 2021/09/13.
//  Copyright © 2021 com.666. All rights reserved.
//

import SwiftUI
import Network

struct BringTabView: View {
    @State private var selection: Tab = .main
    let viewModel: TabViewModel
    
    init() {
        viewModel = TabViewModel(component: UserServiceManagerImpl())
    }
    
    enum Tab {
        case main
        case bookmark
        case my
    }
    
    var body: some View {
        TabView(selection: $selection,
                content:  {
            MainView()
                .tabItem {
                    Label("Main",
                          systemImage: "homepod")
                }
                .tag(Tab.main)
            
            BookmarkView()
                .tabItem {
                    Label("Bookmark",
                          systemImage: "location.viewfinder")
                }
                .tag(Tab.bookmark)
            
            MypageView()
                .tabItem {
                    Label("MyPage",
                          systemImage: "arrow.up.message")
                }
                .tag(Tab.my)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BringTabView()
    }
}
