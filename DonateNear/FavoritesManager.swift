//
//  FavoritesManager.swift
//  DonateNear
//
//  Created by Grant Li on 2025-08-30.
//

import Foundation

@Observable
class FavoritesManager {
    static let shared = FavoritesManager()
    
    private(set) var favoriteFundraisers: [Fundraiser] = []
    
    private init() {}
    
    func addToFavorites(_ fundraiser: Fundraiser){
        if !isFavorite(fundraiser){
            favoriteFundraisers.append(fundraiser)
            print("Added \(fundraiser.title) to favorites")
        }
    }
    
    func removeFromFavorites(_ fundraiser: Fundraiser){
        favoriteFundraisers.removeAll { $0.id == fundraiser.id }
        print("Removed \(fundraiser.title) from favorites")
    }
    
    func isFavorite(_ fundraiser: Fundraiser) -> Bool {
        return favoriteFundraisers.contains{ $0.id == fundraiser.id }
    }
}
