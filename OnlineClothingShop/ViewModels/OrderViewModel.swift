//
//  OrderViewModel.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-31.
//

import Foundation

class OrderViewModel: ObservableObject {
    @Published var orderResult : [OrderData] = []
    
    func createOrder(customerName: String, address: String, mobile: String, email: String, itemDetails: [ItemDetails], completion: @escaping (Result<OrderModel, Error>) -> Void)  {
        // Define the UserPostModel struct or class
        
        // JSON body to send to the server
        let requestBody: [String: Any] = [
                    "headerDetails": [
                        "customerName": customerName,
                        "address": address,
                        "mobile": mobile,
                        "Email": email
                    ],
                    "ItemDetails": itemDetails.map { item in
                        return [
                            "itemName": item.itemName,
                            "itemQuantity": item.itemQuantity,
                            "itemPrice": item.itemPrice
                        ]
                    }
                ]

        
//         Convert the JSON body to Data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            completion(.failure(NSError(domain: "OrderCreateViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to serialize JSON"])))
            return
        }
        
        // Define the URL for your API endpoint
        guard let url = URL(string: "http://localhost:8000/api/v1/order/saveOrder") else {
            completion(.failure(NSError(domain: "OrderCreateViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
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
                completion(.failure(NSError(domain: "OrderCreateViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data returned"])))
                return
            }
            
            // Parse the data into a User object
            do {
                let user = try JSONDecoder().decode(OrderModel.self, from: data)
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
