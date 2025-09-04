//
//  ContentView.swift
//  DonateNear
//
//  Created by Grant Li on 2025-08-23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingHomePage = true
    
    var body: some View {
        if showingHomePage{
            NavigationView{
                HomePageView()
                    .navigationBarHidden(true)
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("NavigateToMainApp"))) { _ in
                showingHomePage = false
            }
        } else {
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
        }
    }
}
