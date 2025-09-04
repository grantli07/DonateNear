//
//  BrowseFundraisersView.swift
//  DonateNear
//
//  Created by Grant Li on 2025-08-24.
//

import SwiftUI
import CoreLocation

struct BrowseFundraisersView: View {
    @State private var locationManager = LocationManager()
    @State private var sortedFundraisers: [Fundraiser] = []
    @State private var favoritesManager = FavoritesManager.shared
    
    var body: some View {
        NavigationView {
            List(sortedFundraisers){ fundraiser in
                NavigationLink(destination: FundraiserDetailView(fundraiser: fundraiser)){
                    VStack(alignment: .leading, spacing: 0){
                        Image(fundraiser.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 100)
                            .clipped()
                        VStack(alignment: .leading, spacing: 8){
                            //Header
                            VStack(alignment: .leading, spacing: 4){
                                HStack{
                                    Text(fundraiser.title)
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .lineLimit(2)
                                    
                                    Spacer()
                                    
                                    if (locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways),
                                       let userLocation = locationManager.location,
                                       let fundraiserLocation = fundraiser.coordinates {
                                        let distance = userLocation.distance(from: fundraiserLocation)/1609.34 //converted to miles
                                        Text(String(format: "%.1f mi", distance))
                                            .font(.caption)
                                            .fontWeight(.medium)
                                            .foregroundColor(.blue)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(
                                                Capsule()
                                                    .fill(.blue.opacity(0.1))
                                            )
                                        Button(action: {
                                            toggleFavorite(fundraiser)
                                        }) {
                                            Image(systemName: favoritesManager.isFavorite(fundraiser) ? "star.fill" : "star")
                                                .font(.title3)
                                                .foregroundColor(favoritesManager.isFavorite(fundraiser) ? .yellow : .gray)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                Text("by \(fundraiser.organizerName)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            //Progress section
                            VStack(alignment: .leading, spacing: 6){
                                VStack(alignment: .leading, spacing: 4){
                                    ProgressView(value: fundraiser.raisedAmount, total: fundraiser.goalAmount)
                                        .progressViewStyle(LinearProgressViewStyle())
                                        .tint(fundraiser.isFullyFunded ? .green : .blue)
                                        .scaleEffect(x: 1, y: 1.5, anchor: .center)
                                
                                HStack{
                                    VStack(alignment: .leading, spacing: 2){
                                        Text("$\(Int(fundraiser.raisedAmount)) raised")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        
                                        Text("of $\(Int(fundraiser.goalAmount)) goal")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    //Percentage badge
                                    Text("\(Int(fundraiser.progressPercentage))%")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(
                                            Capsule()
                                                .fill(fundraiser.isFullyFunded ? .green : .blue)
                                        )
                                }
                            }
                        }
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 12)
                }
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
                    )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(PlainButtonStyle())
            }
            .listStyle(PlainListStyle())
            .refreshable{
                sortFundraisersByDistance()
            }
            //.padding(.horizontal, 4)
            .navigationTitle("Browse Fundraisers")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                locationManager.requestLocationPermission()
                sortedFundraisers = Fundraiser.sampleData
                sortFundraisersByDistance()
            }
            .onChange(of: locationManager.authorizationStatus) { _ in sortFundraisersByDistance()
            }
        }
    }
    
    private func toggleFavorite(_ fundraiser: Fundraiser) {
        if favoritesManager.isFavorite(fundraiser){
            favoritesManager.removeFromFavorites(fundraiser)
        } else {
            favoritesManager.addToFavorites(fundraiser)
        }
    }
    
    private func sortFundraisersByDistance() {
        guard (locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways),
              let userLocation = locationManager.location else {
            sortedFundraisers = Fundraiser.sampleData
            return
        }
        
        sortedFundraisers = Fundraiser.sampleData.sorted { fundraiser1, fundraiser2 in guard let location1 = fundraiser1.coordinates,
                                                                                             let location2 = fundraiser2.coordinates else {
            return false
        }
            let distance1 = userLocation.distance(from: location1)
            let distance2 = userLocation.distance(from: location2)
            
            return distance1 < distance2
        }
    }
}

