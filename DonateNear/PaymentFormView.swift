//
//  PaymentFormView.swift
//  DonateNear
//
//  Created by Grant Li on 2025-08-29.
//

import SwiftUI

struct PaymentFormView: View {
    let fundraiser: Fundraiser
    let donationAmount: Double
    
    @State private var cardNumber = ""
    @State private var expiryDate = ""
    @State private var cvv = ""
    
    var body: some View {
        VStack(spacing: 20){
            VStack(spacing: 8){
                Text("Donating $\(String(format: "%.2f", donationAmount))")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                
                Text("to \(fundraiser.title)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.bottom)
            
            Text("Payment Information")
                .font(.title)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 5){
                Text("Card Number")
                    .font(.headline)
                TextField("1234 5678 9012 3456", text: $cardNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
            }
            
            HStack(spacing: 15) {
                VStack(alignment: .leading, spacing: 5){
                    Text("Expiry Date")
                        .font(.headline)
                    TextField("MM/YY", text: $expiryDate)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                }
                VStack(alignment: .leading, spacing: 5){
                    Text("CVV")
                        .font(.headline)
                    TextField("CVV", text: $cvv)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                }
            }
            NavigationLink(destination: DonationConfirmationView(
                fundraiser: fundraiser,
                donationAmount: donationAmount,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cvv: cvv
            )) {
                Text("Submit Payment")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .disabled(cardNumber.isEmpty || expiryDate.isEmpty || cvv.isEmpty)
            .opacity((cardNumber.isEmpty || expiryDate.isEmpty || cvv.isEmpty) ? 0.6 : 1.0)
        }
        .padding()
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
    }
}
