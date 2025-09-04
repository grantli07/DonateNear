//
//  DonationConfirmationView.swift
//  DonateNear
//
//  Created by Grant Li on 2025-08-30.
//

import SwiftUI

struct DonationConfirmationView: View {
    let fundraiser: Fundraiser
    let donationAmount: Double
    let cardNumber: String
    let expiryDate: String
    let cvv: String
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isProcessing = false
    @State private var paymentCompleted = false
    @State private var paymentSuccessful = false
    @State private var showingResult = false
    
    var body: some View {
        ScrollView{
            VStack(spacing: 24){
                VStack(spacing: 12){
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.green)
                    
                    Text("Confirm Your Donation")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                }
                VStack(spacing: 16){
                    Text("Donation Summary")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 8){
                        HStack{
                            Text("Amount:")
                                .font(.body)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("$\(donationAmount, specifier: "%.2f")")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                        }
                        HStack{
                            Text("To:")
                                .font(.body)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text(fundraiser.title)
                                .font(.body)
                                .fontWeight(.medium)
                                .multilineTextAlignment(.trailing)
                        }
                        HStack{
                            Text("Organizer:")
                                .font(.body)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text(fundraiser.organizerName)
                                .font(.body)
                                .fontWeight(.medium)
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                )
                VStack(spacing: 16){
                    Text("Payment Method")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 12){
                        HStack{
                            Image(systemName: "creditcard.fill")
                                .foregroundColor(.blue)
                            Text("Card Number:")
                                .font(.body)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text(cardNumber)
                                .font(.body)
                                .fontWeight(.medium)
                        }
                        HStack{
                            Image(systemName: "calendar")
                                .foregroundColor(.blue)
                            Text("Expiry:")
                                .font(.body)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text(expiryDate)
                                .font(.body)
                                .fontWeight(.medium)
                        }
                        HStack{
                            Image(systemName: "lock.fill")
                                .foregroundColor(.blue)
                            Text("CVV:")
                                .font(.body)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text(cvv)
                                .font(.body)
                                .fontWeight(.medium)
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                )
                if isProcessing{
                    VStack(spacing: 16){
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .scaleEffect(1.5)
                        
                        Text("Processing your donation...")
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        Text("Please do not close the app")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.blue.opacity(0.1))
                    )
                }
                
                if showingResult{
                    VStack(spacing: 16){
                        Image(systemName: paymentSuccessful ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(paymentSuccessful ? .green : .red)
                        
                        Text(paymentSuccessful ? "Payment Successful!" : "Payment Failed")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(paymentSuccessful ? .green : .red)
                        
                        Text(paymentSuccessful ? "Thank you for your donation to \(fundraiser.title)!" : "Please check your payment details and try again.")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill((paymentSuccessful ? Color.green : .red).opacity(0.1))
                    )
                }
                if !isProcessing && !showingResult{
                    VStack(spacing: 8){
                        HStack{
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(.orange)
                            Text("Please verify all details before confirming")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        
                        Text("Your donation will be processed immediately and cannot be cancelled.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.orange.opacity(0.1))
                    )
                }
                
                VStack(spacing: 12){
                    if !isProcessing && !showingResult{
                        Button(action: {
                            processPayment()
                        }) {
                            HStack{
                                Image(systemName: "heart.fill")
                                Text("Confirm Donation")
                                    .fontWeight(.semibold)
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(.green)
                            )
                        }
                        
                        NavigationLink(destination: PaymentFormView(fundraiser: fundraiser, donationAmount: donationAmount)) {
                            Text("Edit Payment Info")
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundColor(.blue)
                        }
                    } else if showingResult{
                        if paymentSuccessful{
                            Button(action: {
                                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                   let window = windowScene.windows.first {
                                    window.rootViewController = UIHostingController(rootView: MainTabView())
                                }
                            }) {
                                Text("Back to Fundraisers")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 56)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(.blue)
                                    )
                            }
                        } else {
                            Button(action: {
                                resetPayment()
                            }) {
                                Text("Try Again")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 56)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(.orange)
                                    )
                            }
                        }
                    }
                }
                Spacer(minLength: 20)
            }
            .padding()
        }
        .navigationTitle("Confirm")
        .navigationBarTitleDisplayMode(.inline)
    }
    private func processPayment(){
        isProcessing = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            isProcessing = false
            
            paymentSuccessful = Double.random(in: 0...1) < 0.8
            showingResult = true
            
            if paymentSuccessful{
                print("Payment successful: $\(donationAmount) to \(fundraiser.title)")
            } else {
                print("Payment failed: $\(donationAmount) to \(fundraiser.title)")
            }
        }
    }
    
    private func resetPayment(){
        isProcessing = false
        paymentCompleted = false
        paymentSuccessful = false
        showingResult = false
    }
}
