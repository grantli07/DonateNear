//
//  SearchView.swift
//  DonateNear
//
//  Created by Grant Li on 2025-08-24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var selectedFilter = "All"
    @State private var showingSuggestions = false
    @State private var favoritesManager = FavoritesManager.shared
    
    let filterOptions = ["All", "Medical", "Education", "Humanitarian", "Animals", "Community", "Sports"]
    
    var filteredFundraisers: [Fundraiser] {
        var results = Fundraiser.sampleData
        
        if !searchText.isEmpty {
            results = results.filter { fundraiser in
                fundraiser.title.localizedCaseInsensitiveContains(searchText) ||
                fundraiser.description.localizedCaseInsensitiveContains(searchText) ||
                fundraiser.organizerName.localizedCaseInsensitiveContains(searchText) ||
                fundraiser.location.localizedCaseInsensitiveContains(searchText) ||
                fundraiser.category.localizedCaseInsensitiveContains(searchText)
            }
        }
        if selectedFilter != "All" {
            results = results.filter{$0.category == selectedFilter}
        }
        return results
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                
                //Filter chips
                FilterChipsView(selectedFilters: $selectedFilter, filterOptions: filterOptions)
                
                if searchText.isEmpty && selectedFilter == "All" {
                    ScrollView{
                        LazyVStack(spacing: 12){
                            ForEach(Fundraiser.sampleData){ fundraiser in
                                NavigationLink(destination: FundraiserDetailView(fundraiser: fundraiser)) {
                                    FundraiserCard(fundraiser: fundraiser, favoritesManager: favoritesManager)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                    }
                    
                } else {
                    if filteredFundraisers.isEmpty {
                        VStack {
                            Text("No fundraisers found")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.top)
                            
                            Text("Try different keywords or filters")
                                .foregroundStyle(.secondary)
                        }
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                ForEach(filteredFundraisers) { fundraiser in
                                    NavigationLink(destination: FundraiserDetailView(fundraiser: fundraiser)){
                                        FundraiserCard(fundraiser: fundraiser, favoritesManager: favoritesManager)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                .padding()
                            }
                        }
                    }
                    Spacer()
                }
            }
            .navigationTitle("Search")
        }
    }
    
    struct SearchBar: View {
        @Binding var text: String
        
        var body: some View {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search by cause, organizer, or location...", text: $text)
                
                if !text.isEmpty {
                    Button(action: {
                        text = ""
                    }){
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.gray)
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
    
    //New filter chips view
    struct FilterChipsView: View {
        @Binding var selectedFilters: String
        let filterOptions: [String]
        
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12){
                    ForEach(filterOptions, id: \.self) {filter in
                        Button(action: {
                            selectedFilters = filter
                        }){
                            Text(filter)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(
                                    Capsule()
                                        .fill(selectedFilters == filter ? .blue : Color(.systemGray6))
                                )
                                .foregroundColor(selectedFilters == filter ? .white : .primary)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical, 8)
        }
    }
    
    //Reusabale fundraisercard component
    struct FundraiserCard: View{
        let fundraiser: Fundraiser
        let favoritesManager: FavoritesManager
        
        var body: some View{
            VStack(alignment: .leading, spacing: 8){
                HStack{
                    Text(fundraiser.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Button(action: {
                        toggleFavorite()
                    }){
                        Image(systemName: favoritesManager.isFavorite(fundraiser) ? "star.fill" : "star")
                            .font(.title3)
                            .foregroundColor(favoritesManager.isFavorite(fundraiser) ? .yellow : .gray)
                    }
                    .buttonStyle(PlainButtonStyle())
                }

                HStack{
                    Text("by \(fundraiser.organizerName)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    HStack(spacing: 2){
                        Image(systemName: "location")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Text("\(fundraiser.location)")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
                
                ProgressView(value: fundraiser.raisedAmount, total: fundraiser.goalAmount)
                    .tint(fundraiser.isFullyFunded ? .green : .blue)
                
                HStack{
                    Text("$\(Int(fundraiser.raisedAmount)) raised")
                        .font(.caption)
                    
                    Spacer()
                    
                    Text("\(Int(fundraiser.progressPercentage))%")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(fundraiser.isFullyFunded ? .green : .blue)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
        private func toggleFavorite(){
            if favoritesManager.isFavorite(fundraiser){
                favoritesManager.removeFromFavorites(fundraiser)
            } else {
                favoritesManager.addToFavorites(fundraiser)
            }
        }
    }
}
