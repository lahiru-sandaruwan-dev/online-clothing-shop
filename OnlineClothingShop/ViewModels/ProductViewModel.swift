//
//  ProductViewModel.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-29.
//

import Foundation
import SwiftUI

class ProductViewModel : ObservableObject{
    
    @Published var productResult : [PDataModel] = []
    
    func fetch() {
            guard let url = URL(string: "http://localhost:8000/api/v1/product/getProducts") else {
                print("Invalid URL")
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    print("Error fetching data:", error ?? "Unknown error")
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(ProductDataModel.self, from: data)
                    DispatchQueue.main.async {
                        self?.productResult = response.data
                    }
                } catch {
                    print("Error decoding JSON:", error)
                }
            }
            task.resume()
        }
    
    func getById(productId: Any) {
        guard let url = URL(string: "http://localhost:8000/api/v1/product/getProductById/\(productId)") else {
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
                let response = try JSONDecoder().decode(ProductDataModel.self, from: data)
                DispatchQueue.main.async {
                    self.productResult = response.data
                    print(response.data)
                }
            } catch {
                print("Error decoding JSON:", error)
            }
        }
        task.resume()
    }





    
}
    

