//
//  HomeView.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-23.
//

import SwiftUI

struct HomeView: View {
    
    private var categories = [Categories.All.rawValue, Categories.Apparel.rawValue, Categories.Dress.rawValue, Categories.TShirt.rawValue, Categories.Bag.rawValue]
    @State private var selectedCategory:Int = 0
    
    var body: some View {
        ZStack{
            Color.white.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ZStack{
                VStack(spacing: 0){
                    ScrollView(.vertical){
                        HeroImageView()
                        NewArrivalView()
                        Spacer()
                    }
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                }
                .padding(.top, 56)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight : .infinity)
            .overlay(alignment:.top){
                HeaderView{
                    
                } cartAction: {
                    
                }
            }
        }
    }
    
    @ViewBuilder
    private func HeroImageView() -> some View {
        ZStack{
            Image("Hero")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .frame(height: 620)
            
            Button{
                print("Explore Button Clicked")
            } label: {
                RoundedRectangle(cornerRadius: 30).overlay{
                    Text("Explore Collection")
                        .font(Font.custom("Tenor Sans", size: 20))
                        .foregroundColor(.white)
                }
            }
            .frame(width: 253, height: 40)
            .tint(.black.opacity(0.4))
            .offset(.init(width: 0, height: 250))
        }
    }
    
    @ViewBuilder
    private func NewArrivalView() -> some View {
        Text("New Arrival")
            .font(Font.custom("Tenor Sans", size: 25))
            .multilineTextAlignment(.center)
            .foregroundColor(.black)
            .frame(width: 225, height: 32, alignment: .top)
            .padding(.top, 25)
        
        Image("Divider")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 140)
            .padding(.top, 10)
        
        VStack{
            HStack(spacing: 20){
                ForEach(0..<categories.count, id: \.self) { i in
                    CategoryView(isSelected: i == selectedCategory, title: categories[i])
                        .onTapGesture {
                            selectedCategory = i
                        }
                }
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .padding(.bottom, 15)
            
            HStack {
                ProductItemView(product: product1)
                ProductItemView(product: product2)
            }
            HStack {
                ProductItemView(product: product3)
                ProductItemView(product: product4)
            }
            
            Button {
                
            } label: {
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8){
                    Text("Explore More")
                        .font(tenorSans(20))
                        .multilineTextAlignment(.center)
                    
                    Image(systemName: "arrow.forward")
                        .frame(width: 10, height: 10)

                }
            }
            .tint(Color.BodyGrey)
            .padding(12)
        }
    }
    
    @ViewBuilder
    private func CollectionsView() -> some View {
        
    }
    
    @ViewBuilder
    private func SideMenu() -> some View {
        
    }
    
    @ViewBuilder
    private func SideCart() -> some View {
        
    }
}

#Preview {
    HomeView()
}
