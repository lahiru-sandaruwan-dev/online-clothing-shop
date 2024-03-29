//
//  LoginViewModel.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-24.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var items = [UserLoginDataModel]()
    let prefixUrl = "http://localhost:8000/api/v1"
        
    
    func login(email: String, password: String, completion: @escaping (Result<UserLoginDataModel, Error>) -> Void) {
        // Define the UserPostModel struct or class
        
        // JSON body to send to the server
        let requestBody = ["email": email, "password": password]

        
//         Convert the JSON body to Data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            completion(.failure(NSError(domain: "UserLoginViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to serialize JSON"])))
            return
        }
        
        // Define the URL for your API endpoint
        guard let url = URL(string: "http://localhost:8000/api/v1/user/login")  else {
            completion(.failure(NSError(domain: "UserLoginViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Check for errors
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Check if there's data returned
            guard let data = data else {
                completion(.failure(NSError(domain: "UserLoginViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data returned"])))
                return
            }
            
            // Parse the data into a User object
            do {
                let user = try JSONDecoder().decode(UserLoginDataModel.self, from: data)
                completion(.success(user))
            } catch {
                // Print response if decoding error occurs
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response: \(responseString)")
                }
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

}
