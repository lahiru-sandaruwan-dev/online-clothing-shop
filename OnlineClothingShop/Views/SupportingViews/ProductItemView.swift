//
//  ProductItemView.swift
//  OnlineClothingShop
//
//  Created by Akindu Bogahawatta on 2024-03-23.
//

import SwiftUI

struct ProductItemView: View {
    var product: ProductModel
    var body: some View {
            Button {
                
            } label: {
                VStack {
                    Image(product.images[0])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 165, height: 200)
                        .cornerRadius(5)
                        .shadow(radius: 1)
                    
                    Text(product.title)
                        .font(Font.custom("Tenor Sans", size: 11))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.BodyGrey)
                        .frame(width: 165, alignment: .top)
                    
                    Text("$\(product.price)")
                        .font(Font.custom("Tenor Sans", size: 14))
                        .foregroundColor(Color.Default)
                        .padding(.top, 2)
            }
        }
    }
}

struct ProdutItemView_Previews: PreviewProvider{
    static var previews: some View {
        ProductItemView(product: product1)
    }
}
