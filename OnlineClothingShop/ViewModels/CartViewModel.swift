//
//  CartViewModel.swift
//  OnlineClothingShop
//
//  Created by Akindu Bogahawatta on 2024-03-30.
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





    
}
