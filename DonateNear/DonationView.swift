//
//  DonationView.swift
//  DonateNear
//
//  Created by Grant Li on 2025-08-28.
//

import SwiftUI

struct DonationView: View {
    let fundraiser: Fundraiser
    @State private var selectedAmount: Double = 0
    @State private var customAmount: String = ""
    @State private var isCustomAmountSelected: Bool = false
    
    private let predefinedAmounts: [Double] = [5, 10, 25, 50, 100]
    
    var body: some View {
        ScrollView{
            VStack(spacing: 24){
                VStack(spacing: 12){
                    Text("Donate to")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                
                Text(fundraiser.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("by \(fundraiser.organizerName)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            VStack(alignment: .leading, spacing: 16){
                Text("Select an amount")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 12){
                    ForEach(predefinedAmounts, id: \.self){ amount in
                        Button(action: {
                            selectedAmount = amount
                            isCustomAmountSelected = false
                            customAmount = ""
                        }) {
                            Text("$\(Int(amount))")
                                .font(.headline)
                                .fontWeight(.medium)
                                .foregroundColor(selectedAmount == amount ? .white : .blue)
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(selectedAmount == amount ? .blue : .blue.opacity(0.1))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(.blue, lineWidth: selectedAmount == amount ? 0 : 1)
                                )
                        }
                    }
                }
            }
            VStack(alignment: .leading, spacing: 12){
                Text("Or enter a custom amount")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                HStack{
                    Text("$")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                    
                    TextField("Enter amount:", text: $customAmount)
                        .keyboardType(.decimalPad)
                        .font(.title2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: customAmount) { _ in
                            if !customAmount.isEmpty {
                                selectedAmount = Double(customAmount) ?? 0
                                isCustomAmountSelected = true
                            } else {
                                selectedAmount = 0
                                isCustomAmountSelected = false
                            }
                        }
                }
            }
            
            if selectedAmount > 0 {
                VStack(spacing: 8){
                    Text("Your donation")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("$\(String(format: "%.2f", selectedAmount))")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.green.opacity(0.1))
                )
            }
            
            Spacer(minLength: 20)
            
            NavigationLink(destination: PaymentFormView(fundraiser: fundraiser, donationAmount: selectedAmount)){
                HStack{
                    Image(systemName: "heart.fill")
                    Text("Donate $\(String(format: "%.0f", selectedAmount))")
                        .fontWeight(.semibold)
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(selectedAmount > 0 ? .blue : .gray)
                )
            }
            .disabled(selectedAmount <= 0)
            .opacity(selectedAmount > 0 ? 1.0 : 0.6)
        }
        .padding()
        .navigationTitle("Donate")
        .navigationBarTitleDisplayMode(.inline)
    }
}



