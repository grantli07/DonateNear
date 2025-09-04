//
//  FavoritesView.swift
//  DonateNear
//
//  Created by Grant Li on 2025-08-24.
//

import SwiftUI
import CoreLocation

struct FavoritesView: View {
    @State private var favoritesManager = FavoritesManager.shared
    
    var body: some View {
        NavigationView{
            if favoritesManager.favoriteFundraisers.isEmpty {
                VStack{
                    Image(systemName: "star.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.yellow)
                        .padding(.bottom)
                    
                    Text("Your Favourite Fundraisers")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top)
                    
                    Text("Fundraisers you save will appear here")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Spacer()
                }
                .navigationTitle("Favorites")
            } else {
                List(favoritesManager.favoriteFundraisers){ fundraiser in
                    NavigationLink(destination: FundraiserDetailView(fundraiser: fundraiser)){
                        VStack(alignment: .leading, spacing: 0){
                            Image(fundraiser.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 100)
                                .clipped()
                            
                            VStack(alignment: .leading, spacing: 8){
                                VStack(alignment: .leading, spacing: 4){
                                    HStack{
                                        Text(fundraiser.title)
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                            .lineLimit(2)
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            favoritesManager.removeFromFavorites(fundraiser)
                                        }) {
                                            Image(systemName: "star.fill")
                                                .font(.title3)
                                                .foregroundColor(.yellow)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                    
                                    Text("by \(fundraiser.organizerName)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                    VStack(alignment: .leading, spacing: 6){
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
                            .padding(.horizontal, 12)
                            .padding(.vertical, 12)
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
                .navigationTitle("Favorites")
                .navigationBarTitleDisplayMode(.large)
            }
        }
    }
}
