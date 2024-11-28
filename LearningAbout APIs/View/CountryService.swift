//
//  CountryService.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 11/27/24.
//


import Foundation

class CountryService {
    func fetchCountries(completion: @escaping ([Country]?, String?) -> Void) {
        let urlString = "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"
        
        // Ensure the URL is valid
        guard let url = URL(string: urlString) else {
            completion(nil, "Invalid URL")
            return
        }
        
        // Perform the network call
        URLSession.shared.dataTask(with: url) { data, response, error in
            // If there's an error, return it
            if let error = error {
                completion(nil, error.localizedDescription)
                return
            }
            
            // Make sure we have data
            guard let data = data else {
                completion(nil, "No data received")
                return
            }
            
            // Try to decode the data
            do {
                let countries = try JSONDecoder().decode([Country].self, from: data)
                completion(countries, nil)
            } catch {
                completion(nil, "Failed to decode data: \(error.localizedDescription)")
                print("Decoding error: \(error)") // Added for better debugging
            }
        }.resume()
    }
}
