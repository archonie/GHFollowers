//
//  GFError.swift
//  GHFollowers
//
//  Created by Doğan Ensar Papuçcuoğlu on 9.12.2024.
//

import Foundation

enum GFError: String, Error {
    
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "Invalid data received from the server. Please try again."
    case unableToFavorite = "There was an error favoriting this user. Please try again."
    case unableToRetrieveFavorites = "There was an error retrieving favorites. Please try again."
    case alreadyInFavorites = "You have already favorited this user. You must REALLY like them!"
}
