//
//  MainTabView.swift
//  DonateNear
//
//  Created by Grant Li on 2025-08-31.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView{
            BrowseFundraisersView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Browse")
                }
            
            SearchView()
                .tabItem{
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .navigationBarHidden(true)
    }
}
