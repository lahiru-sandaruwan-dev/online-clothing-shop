//
//  UserViewModel.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-24.
//

import Foundation
import SwiftUI

class UserViewModel: ObservableObject {
    @Published var userResult: [UPostModel] = []
    let prefixUrl = "http://localhost:8000/api/v1"
    
    init() {
//        getUsers()
    }
    
    
    func getUserById(userId: String) {
        guard let url = URL(string: "http://localhost:8000/api/v1/user/getUser/\(userId)") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data:", error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Unexpected response:", response ?? "No response")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let response = try JSONDecoder().decode(UDataModel.self, from: data)
                DispatchQueue.main.async {
                    self.userResult = response.data
                    print(response.data)
                }
            } catch {
                print("Error decoding JSON:", error)
            }
        }
        task.resume()
    }

    
    
    func createUser(firstname: String, lastname: String, email: String, picture: String, password: String, role: String, mobile: String, address: String, completion: @escaping (Result<UserDataModel, Error>) -> Void) {
        // Define the UserPostModel struct or class
        
        // JSON body to send to the server
        let requestBody = ["firstName": firstname,"lastName": lastname, "email": email, "picture": picture, "password": password, "role": role, "mobile": mobile,"address": address ]

        
//         Convert the JSON body to Data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            completion(.failure(NSError(domain: "UserCreateViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to serialize JSON"])))
            return
        }
        
        // Define the URL for your API endpoint
        guard let url = URL(string: "http://localhost:8000/api/v1/user/create") else {
            completion(.failure(NSError(domain: "UserCreateViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
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
                completion(.failure(NSError(domain: "UserCreateViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data returned"])))
                return
            }
            
            // Parse the data into a User object
            do {
                let user = try JSONDecoder().decode(UserDataModel.self, from: data)
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
    
    func udateUser(userId : String, firstname: String, lastname: String, mobile: String, address: String, completion: @escaping (Result<UserDataModel, Error>) -> Void) {
        // Define the UserPostModel struct or class
        
        // JSON body to send to the server
        let requestBody = ["firstName": firstname,"lastName": lastname, "mobile": mobile,"address": address ]

        
//         Convert the JSON body to Data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            completion(.failure(NSError(domain: "UserUpdateViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to serialize JSON"])))
            return
        }
        
        // Define the URL for your API endpoint
        guard let url = URL(string: "http://localhost:8000/api/v1/user/update/\(userId)") else {
            completion(.failure(NSError(domain: "UserUpdateViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
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
                completion(.failure(NSError(domain: "UserUpdateViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data returned"])))
                return
            }
            
            // Parse the data into a User object
            do {
                let user = try JSONDecoder().decode(UserDataModel.self, from: data)
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
