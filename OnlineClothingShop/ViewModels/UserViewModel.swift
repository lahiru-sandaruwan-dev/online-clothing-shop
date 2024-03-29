//
//  UserViewModel.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-24.
//

import Foundation
import SwiftUI

class UserViewModel: ObservableObject {
//    @Published var items = [UserDataModel]()
    let prefixUrl = "http://localhost:8000/api/v1"
    
    init() {
//        getUsers()
    }
    
    //MARK: - Retrival User Data
//    func getUsers() {
//        guard let url = URL(string: "\(prefixUrl)/user/getUsers") else {
//            print("Not found url")
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) {(data, res, error) in
//            if error != nil {
//                print("error", error?.localizedDescription ?? "")
//                return
//            }
//            
//            do {
//                if let data = data {
//                    let result = try JSONDecoder().decode(UserDataModel.self, from: data)
//                    DispatchQueue.main.async {
//                        self.items = result.data
//                    }
//                } else {
//                    print("No data")
//                }
//                
//            } catch let JsonError {
//                print("fetch json error:", JsonError.localizedDescription)
//            }
//        }.resume()
//    }
    
    
    func createUser(firstname: String, lastname: String, email: String, picture: String, password: String, role: String, completion: @escaping (Result<UserDataModel, Error>) -> Void) {
        // Define the UserPostModel struct or class
        
        // JSON body to send to the server
        let requestBody = ["firstName": firstname,"lastName": lastname, "email": email, "picture": picture, "password": password, "role": role]

        
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

    
    
//    func createUser(parameters: [String: Any]) {
//        guard let url = URL(string: "\(prefixUrl)/user/create") else {
//            print("Not found url")
//            return
//        }
//        
//        do {
//            // Convert parameters to JSON data
//            let jsonData = try JSONSerialization.data(withJSONObject: parameters)
//            
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.httpBody = jsonData
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            
//            URLSession.shared.dataTask(with: request) { (data, response, error) in
//                if let error = error {
//                    print("Error:", error.localizedDescription)
//                    return
//                }
//                
//                if let data = data {
//                    do {
//                        let result = try JSONDecoder().decode(UserDataModel.self, from: data)
//                        DispatchQueue.main.async {
//                            print(result)
//                            // Do something with the decoded result
//                        }
//                    } catch {
//                        print("Error decoding JSON:", error.localizedDescription)
//                    }
//                } else {
//                    print("No data")
//                }
//            }.resume()
//        } catch {
//            print("Error serializing JSON:", error.localizedDescription)
//        }
//    }


    
    //MARK: - Update User
    func updateUser(parameters: [String: Any]) {
        guard let url = URL(string: "\(prefixUrl)/user/update") else {
            print("Not found url")
            return
        }
         
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url) {(data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(UserDataModel.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                    }
                } else {
                    print("No data")
                }
                
            } catch let JsonError {
                print("fetch json error:", JsonError.localizedDescription)
            }
        }.resume()
    }
    
    //MARK: - Delete User
    func deleteUser(parameters: [String: Any]) {
        guard let url = URL(string: "\(prefixUrl)/user/deleteUser") else {
            print("Not found url")
            return
        }
         
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url) {(data, res, error) in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(UserDataModel.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                    }
                } else {
                    print("No data")
                }
                
            } catch let JsonError {
                print("fetch json error:", JsonError.localizedDescription)
            }
        }.resume()
    }
}
