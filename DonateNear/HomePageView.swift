//
//  HomePageView.swift
//  DonateNear
//
//  Created by Grant Li on 2025-08-31.
//

import SwiftUI

struct HomePageView: View {
    @State private var animateGradient = false
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                LinearGradient(
                    colors: [
                        Color(red: 0.1, green: 0.4, blue: 0.8),
                        Color(red: 0.2, green: 0.6, blue: 0.9),
                        Color(red: 0.3, green: 0.7, blue: 0.95)
                    ],
                    startPoint: animateGradient ? .topLeading : .bottomTrailing,
                    endPoint: animateGradient ? .bottomTrailing : .topLeading
                )
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 3).repeatForever(autoreverses: true)){
                        animateGradient.toggle()
                    }
                }
                Circle()
                    .fill(.white.opacity(0.1))
                    .frame(width: 200, height: 200)
                    .position(x: geometry.size.width * 0.8, y: geometry.size.height * 0.2)
                
                Circle()
                    .fill(.white.opacity(0.05))
                    .frame(width: 150, height: 150)
                    .position(x: geometry.size.width * 0.2, y: geometry.size.height * 0.7)
                
                VStack(spacing: 40){
                    Spacer()
                    
                    VStack(spacing: 20){
                        // App icon/logo
                        Image("Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
    
                        VStack(spacing: 8){
                            Text("DonateNear")
                                .font(.system(size: 42, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            
                            Text("Support causes in your community")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(.white.opacity(0.9))
                                .multilineTextAlignment(.center)
                        }
                    }
                    Spacer()
                    
                    VStack(spacing: 16){
                        FeatureRow(icon: "location.fill", text: "Discover local fundraisers")
                        FeatureRow(icon: "heart.fill", text: "Make secure donations")
                        FeatureRow(icon: "star.fill", text: "Save your favorites")
                    }
                    .padding(.horizontal, 40)
                    Spacer()
                    
                    VStack(spacing: 16){
                        NavigationLink(destination: MainTabView()) {
                            HStack{
                                Image(systemName: "arrow.right.circle.fill")
                                    .font(.headline)
                                Text("Get Started!")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(Color(red: 0.1, green: 0.4, blue: 0.8))
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(.white)
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                        }
                    }
                    .padding(.horizontal, 32)
                    Spacer()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12){
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 24)
            
            Text(text)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.white.opacity(0.9))
            
            Spacer()
        }
    }
}
