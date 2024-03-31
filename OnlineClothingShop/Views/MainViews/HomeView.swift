//
//  HomeView.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-23.
//

import SwiftUI

struct HomeView: View {
    
    @State var presentSideMenu = false
    @State var presentSideCart = false
    @State private var search = ""
    
    private var categories = [Categories.All.rawValue, Categories.Apparel.rawValue, Categories.Dress.rawValue, Categories.TShirt.rawValue, Categories.Bag.rawValue]
    @State private var selectedCategory: Int = 0
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                ZStack {
                    VStack(spacing: 0) {
                        HStack {
                            TextField("Search Products ...", text: $search)
                                .padding()
                                .frame(width: 300)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                
                                Image("Search")
                                .resizable()
                                .padding(.all, 10)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .background(Color.Line)
                        }
                        .padding()
                        .edgesIgnoringSafeArea(.all)
                        ScrollView(.vertical) {
                            HeroImageView()
//                            NewArrivalView()
                            Image("Brand")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            CollectionsView()
//                            TrendingHashtagsView()
                            FooterView()
                            Spacer()
                        }
                        NavigationBarView()
                       
                    }
                    .padding(.top, 54)
                   
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(alignment: .top) {
                    HeaderView {
                        presentSideMenu.toggle()
                    } cartAction: {
                        presentSideCart.toggle()
                    }
                }
                
//                SideMenu()
//                SideCart()
            }
            .navigationBarHidden(true)
        }
    }
    
    @ViewBuilder
    private func HeroImageView() -> some View {
        
        NavigationLink {
            ProductsList()
        } label: {
            ZStack {
                Image("wp7915262-clothing-women-wallpapers")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 600)
                VStack {
                    Text("Get Your Dream Cloths")
                        .foregroundColor(.white)
                        .bold()
                        .font(.largeTitle)
                    Text("Today")
                        .foregroundColor(.white)
                        .bold()
                        .font(.largeTitle)
                }
                
                
                Button {
                    print("Explore Collection Button Clicked")
                } label: {
                    RoundedRectangle(cornerRadius: 15).overlay {
                        Text("Explore Collection")
                            .font(Font.custom("Tenor Sans", size: 20))
                            .foregroundColor(.white)
                    }
                }
                .frame(width: 253, height: 40)
                .tint(.white.opacity(0.4))
                .offset(.init(width: 0, height: 150))

            }
        }
       
    }
    
    @ViewBuilder
    private func NewArrivalView() -> some View {
        Text("New Arrival")
            .font(Font.custom("Tenor Sans", size: 28))
            .multilineTextAlignment(.center)
            .foregroundColor(.black)
            .frame(width: 225, height: 32, alignment: .top)
            .padding(.top, 25)
        
        Image("Divider")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 140)
            .padding(.top, 10)
        
    }
    
    
    @ViewBuilder
    private func CollectionsView() -> some View {
        Text("Collections")
            .font(tenorSans(28))
            .foregroundColor(Color.black)
        
        NavigationLink {
            ProductsList()
        } label: {
            Image("wp6130531-women-group-wallpapers")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 244, alignment: .top)
                .clipped()
            
        }
        
        NavigationLink {
            ProductsList()
        } label: {
            Image("wp6036446-the-women-in-the-black-wallpapers")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 244, alignment: .top)
                .clipped()
        }

        Image("Divider")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 140)
            .padding(.top, 10)
        
    }
 
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

