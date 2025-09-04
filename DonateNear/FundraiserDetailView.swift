//
//  FundraiserDetailView.swift
//  DonateNear
//
//  Created by Grant Li on 2025-08-27.
//

import SwiftUI

struct FundraiserDetailView: View {
    let fundraiser: Fundraiser
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 0){
                ZStack(alignment: .bottomLeading) {
                    Image(fundraiser.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 180)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .overlay(
                            LinearGradient(
                                colors: [
                                    Color.black.opacity(0),
                                    Color.black.opacity(0.3),
                                    Color.black.opacity(0.6)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(fundraiser.title)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "person.circle.fill")
                                .foregroundColor(.white.opacity(0.9))
                                .font(.caption)
                            Text("by \(fundraiser.organizerName)")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.9))
                                .fontWeight(.medium)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 15){
                        Text("About this fundraiser")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                        
                        Text(fundraiser.description)
                            .font(.body)
                            .lineSpacing(4)
                            .lineLimit(nil)
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack{
                            VStack(alignment: .leading, spacing: 4){
                                Text("$\(Int(fundraiser.raisedAmount)) raised")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                                
                                Text("of $\(Int(fundraiser.goalAmount)) goal")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Text("\(Int(fundraiser.progressPercentage))%")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(
                                    Capsule()
                                        .fill(fundraiser.isFullyFunded ? .green : .blue)
                                )
                        }
                        
                        ProgressView(value: fundraiser.raisedAmount, total: fundraiser.goalAmount)
                            .progressViewStyle(LinearProgressViewStyle())
                            .tint(fundraiser.isFullyFunded ? .green : .blue)
                            .scaleEffect(x: 1, y: 2, anchor: .center)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                    )
                    
                    HStack(spacing: 8){
                        Image(systemName: "location.fill")
                            .foregroundColor(.blue)
                            .font(.subheadline)
                        Text(fundraiser.location)
                            .font(.subheadline)
                            .foregroundColor(.primary)
                            .fontWeight(.medium)
                        Spacer()
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.blue.opacity(0.1))
                    )
                    
                    //Donate button
                    NavigationLink(destination: DonationView(fundraiser: fundraiser)){
                        Text("Donate Now!")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(fundraiser.isFullyFunded ? Color.green : Color.blue)
                            .cornerRadius(12)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.top, 20)
                    
                }
                .padding(.horizontal, 20)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
