//
//  Fundraiser.swift
//  DonateNear
//
//  Created by Grant Li on 2025-08-26.
//

import Foundation
import CoreLocation

//Fundraiser struct with properties for each fundraiser and makes them identifable in the UI
struct Fundraiser: Identifiable{
    let id = UUID()
    let title: String
    let description: String
    let goalAmount: Double
    let raisedAmount: Double
    let organizerName: String
    let location: String
    let coordinates: CLLocation?
    let category: String
    let imageName: String
    
    //Computed properties to calculate fundraiser progress
    var progressPercentage: Double {
        guard goalAmount > 0 else {return 0}
        return min(raisedAmount/goalAmount * 100, 100)
    }
    
    var remainingAmount: Double {
        return max(goalAmount - raisedAmount, 0)
    }
    
    var isFullyFunded: Bool {
        return raisedAmount >= goalAmount
    }
}

extension Fundraiser{
    static let sampleData: [Fundraiser] = [
        Fundraiser(
            title: "Help Build Clean Water Wells",
            description: "Providing clean drinking water to rural communities in need. Every donation helps us reach more families!",
            goalAmount: 5000.00,
            raisedAmount: 3200.0,
            organizerName: "Clean Water Foundation",
            location: "San Francisco, CA",
            coordinates: CLLocation(latitude: 37.7749, longitude: -122.4194),
            category: "Humanitarian",
            imageName: "water-well"
        ),
        Fundraiser(
            title: "Medical Treatment for Sarah",
            description: "Help cover medical expenses for Sarah's cancer treatment. Your support means everything to our family.",
            goalAmount: 15000.00,
            raisedAmount: 8900.00,
            organizerName: "Johnson Family",
            location: "Austin, TX",
            coordinates: CLLocation(latitude: 30.2672, longitude: -97.7431),
            category: "Medical",
            imageName: "medical-treatment"
        ),
        Fundraiser(
            title: "School Library Books",
            description: "Raising funds to purchase new books for our elementary school library. Let's inspire young readers together!",
            goalAmount: 2500.00,
            raisedAmount: 2500.00,
            organizerName: "Riverside Elementary School",
            location: "Portland, OR",
            coordinates: CLLocation(latitude: 45.5152, longitude: -122.6784),
            category: "Education",
            imageName: "school-books"
        ),
        Fundraiser(
            title: "Fundraiser for Local Animal Shelter",
            description: "Donate to support caretakers in taking care of our furry friends at the local animal shelter.",
            goalAmount: 8000.00,
            raisedAmount: 6800.00,
            organizerName: "Bay Area Animal Society",
            location: "Oakland, CA",
            coordinates: CLLocation(latitude: 37.8044, longitude: -122.2712),
            category: "Animals",
            imageName: "animal-shelter"
        ),
        Fundraiser(
            title: "Help David Buy School Supplies",
            description: "Raising funds to purchase new school supplies for David. Let's support his education journey!",
            goalAmount: 800.00,
            raisedAmount: 1000.00,
            organizerName: "David's Family",
            location: "Atlanta, GA",
            coordinates: CLLocation(latitude: 33.7490, longitude: -84.3880),
            category: "Education",
            imageName: "school-supplies"
        )
    ]
}
