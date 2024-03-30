//
//  CartViewModel.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-30.
//

import Foundation
import SwiftUI

class CartViewModel : ObservableObject{
    
    @Published var productCartResult : [PCartModel] = []
    
    
    func getCartByUserId(userId: Any) {
        guard let url = URL(string: "http://localhost:8000/api/v1/productCart/getCartDetailsById/userId=\(userId)") else {
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
                let response = try JSONDecoder().decode(ProductCartModel.self, from: data)
                DispatchQueue.main.async {
                    self.productCartResult = response.data
                    print(response.data)
                }
            } catch {
                print("Error decoding JSON:", error)
            }
        }
        task.resume()
    }

    func addProductToCart(productName: String, size: String, color: String, requestedQuantity: String, userId: String, completion: @escaping (Result<ProductCartModel, Error>) -> Void) {
        // Define the UserPostModel struct or class
        
        // JSON body to send to the server
        let requestBody = ["productName": productName,"size": size, "color": color, "requestedQuantity": requestedQuantity, "userId": userId] 

        
//         Convert the JSON body to Data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            completion(.failure(NSError(domain: "UserCreateViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to serialize JSON"])))
            return
        }
        
        // Define the URL for your API endpoint
        guard let url = URL(string: "http://localhost:8000/api/v1/productCart/saveCart") else {
            completion(.failure(NSError(domain: "CartViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
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
                completion(.failure(NSError(domain: "CartViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data returned"])))
                return
            }
            
            // Parse the data into a User object
            do {
                let user = try JSONDecoder().decode(ProductCartModel.self, from: data)
                completion(.success(user))
            } catch {
                // Print response if decoding error occurs
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response: \(responseString)")
                    UserSession.shared.message = responseString
                }
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

    func deleteProductFromCart(productId: String) {
        guard let url = URL(string: "http://localhost:8000/api/v1/productCart/deleteCartItems/productId=\(productId)") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error deleting product from cart:", error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Unexpected response:", response ?? "No response")
                return
            }

            print("Product deleted successfully from the cart")

            // You may want to handle UI updates or any other logic after successful deletion here
        }
        task.resume()
    }


    
}
