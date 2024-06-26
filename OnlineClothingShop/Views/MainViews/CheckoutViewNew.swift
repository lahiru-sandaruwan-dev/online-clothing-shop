//
//  CheckoutViewNew.swift
//  OnlineClothingShop
//
//  Created by Lahiru Sandaruwan on 2024-03-30.
//

import SwiftUI

struct CheckoutViewNew: View {
    @StateObject var cartVM = CartViewModel()
    @StateObject var userVM = UserViewModel()
    @StateObject var orderVM = OrderViewModel()
    
    @State var presentSideMenu = false
    @State var presentSideCart = false
    @State var isAleart = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    var userId: String
    
    //    private let adaptiveColumns = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                ZStack {
                    VStack(spacing: 0) {
                        Spacer()
                        HStack {
                            Text("Check Out")
                                .font(tenorSans(24))
                                .foregroundColor(.black)
                                .padding(.leading, 10)
                            Spacer()
                        }
                        .onAppear {
                            cartVM.getCartByUserId(userId: userId)
                            let userID = UserSession.shared.userId
                            userVM.getUserById(userId: userId )
                        }
                        
                        VStack{
                            Text("Order Details")
                                .font(tenorSans(24))
                            //                                .padding()
                            Image("Divider")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 400)
                            //                                .padding(.top, 20)
                            ForEach(userVM.userResult, id: \._id){ user in
                                HStack{
                                    VStack(alignment: .leading){
                                        Text("Name")
                                            .font(tenorSans(20))
                                            .padding(2)
                                        Text("Address")
                                            .font(tenorSans(20))
                                            .padding(2)
                                        Text("E-mail")
                                            .font(tenorSans(20))
                                            .padding(2)
                                        Text("Mobile")
                                            .font(tenorSans(20))
                                            .padding(2)
                                    }
                                    .padding()
                                    VStack(alignment: .leading) {
                                        Text(": \(user.firstName) \(user.lastName)")
                                            .font(tenorSans(20))
                                            .padding(2)
                                        Text(": \(user.address)")
                                            .font(tenorSans(20))
                                            .padding(2)
                                        Text(": \(user.email)")
                                            .font(tenorSans(20))
                                            .padding(2)
                                        Text(": \(user.mobile)")
                                            .font(tenorSans(20))
                                            .padding(2)
                                    }
                                    
                                }
                                .frame(width: 340)
                                .padding()
                                .aspectRatio(contentMode: .fit)
                                .background(Color.Dark.opacity(0.2))
                                .cornerRadius(15)
                                
                            }
                            
                        }
                        
                        ScrollView(.vertical, showsIndicators: false){
                            LazyVStack(spacing: 0){
                                
                                
                                
                                ForEach(cartVM.productCartResult, id: \._id){ product in
                                    
                                    HStack(spacing: 20) {
                                        Image(product.productImage)
                                            .resizable()
                                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(15)
                                        
                                        VStack(alignment: .leading, spacing: 10) {
                                            Text(product.productName)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.black)
                                            
                                            HStack(spacing: 15) {
                                                Text(getPrice(value: Float(product.productPrice)))
                                                    .font(.title2)
                                                    .fontWeight(.heavy)
                                                    .foregroundColor(.black)
                                                
                                                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                                                
                                            }
                                            
                                            HStack{
                                                Button(action : {
                                                    cartVM.productCartResult[getIndex(product: product)].requestedQuantity -= 1
                                                }) {
                                                    Image(systemName: "minus")
                                                        .font(.system(size: 16, weight: .heavy))
                                                        .foregroundColor(.black)
                                                }
                                                
                                                Text("\(cartVM.productCartResult[getIndex(product: product)].requestedQuantity)")
                                                    .fontWeight(.heavy)
                                                    .foregroundColor(.black)
                                                    .padding(.vertical, 5)
                                                    .padding(.horizontal, 10)
                                                    .background(Color.black.opacity(0.06))
                                                
                                                Button(action : {
                                                    cartVM.productCartResult[getIndex(product: product)].requestedQuantity += 1
                                                }) {
                                                    Image(systemName: "plus")
                                                        .font(.system(size: 16, weight: .heavy))
                                                        .foregroundColor(.black)
                                                }
                                                Spacer()
                                                Button(action : {
                                                    let userId = UserSession.shared.userId
                                                    cartVM.deleteProductFromCart(productId: product._id)
                                                    cartVM.getCartByUserId(userId: userId ?? "")
                                                }, label : {
                                                    Image(systemName: "trash")
                                                        .font(.title3)
                                                        .foregroundColor(Color.red)
                                                })
                                            }
                                            .padding(.top , 10)
                                        }
                                        .padding()
                                    }
                                    .padding(30)
                                    
                                }
                            }
                            .background(Color.gray.opacity(0.1))
                            
                            
                            .padding(.top, 20)
                        }
                        VStack {
                            HStack {
                                Text("Total")
                                    .fontWeight(.heavy)
                                Spacer()
                                
                                Text(calculateTotalPrice())
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.black)
                            }
                            .padding([.top, .horizontal])
                            
                            .alert(isPresented: $isAleart, content: {
                                let firstname = Text("No data")
                                let message = Text("Please fill all fields!")
                                return Alert(title: firstname, message: message)
                            })
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                            }
                            
                            ForEach(userVM.userResult, id:\.self){ user in
                                
                                Button(action : {
                                    if let userId = UserSession.shared.userId {
                                                var itemDetails = [ItemDetails]() 
                                                
                                                for product in cartVM.productCartResult {
                                                    // Append each product's details to itemDetails
                                                    itemDetails.append(ItemDetails(
                                                        itemName: product.productName,
                                                        itemQuantity: product.requestedQuantity,
                                                        itemPrice: product.productPrice
                                                    ))
                                                }
                                                
                                                orderVM.createOrder(
                                                    customerName: user.firstName,
                                                    address: user.address,
                                                    mobile: user.mobile,
                                                    email: user.email,
                                                    itemDetails: itemDetails
                                                ) { result in
                                                    switch result {
                                                    case .success(let order):
                                                        // Handle success response
                                                        self.alertMessage = "Order created successfully"
                                                        self.showAlert = true
                                                        print("Order created successfully: \(order)")
                                                        
                                                    case .failure(let error):
                                                        // Handle failure response
                                                        self.alertMessage = "Failed to create order: \(error.localizedDescription)"
                                                        self.showAlert = true
                                                        print("Error creating order: \(error)")
                                                    }
                                                }
                                            } else {
                                               
                                            }
                                }, label: {
                                    Text("Place Order")
                                        .font(tenorSans(20))
                                        .bold()
                                        .foregroundColor(.white)
                                        .frame(width: 300, height: 50)
                                        .background(Color.Dark.opacity(0.7))
                                        .cornerRadius(10)
                                })
                            }
                            
                        }
                        .padding(10)
                        
                        NavigationBarView()
                            .edgesIgnoringSafeArea(.all)
                    }
                    .padding(.top, 56)
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
    func getIndex(product: PCartModel)->Int{
        return cartVM.productCartResult.firstIndex {
            (product1)-> Bool in
            return product._id == product1._id
        } ?? 0
    }
    
    func getPrice(value : Float)-> String {
        let format = NumberFormatter()
        format.numberStyle = .currency
        
        return format.string(from: NSNumber(value: value)) ?? ""
    }
    
    func calculateTotalPrice()->String {
        var price: Float = 0
        
        cartVM.productCartResult.forEach{ (item) in
            price += Float(item.requestedQuantity) * Float(item.productPrice)
        }
        
        return getPrice(value: price)
    }
    
    
    //    @ViewBuilder
    //    private func SideMenu() -> some View {
    //        SideView(isShowing: $presentSideMenu, content: AnyView(SideMenuViewContents(presentSideMenu: $presentSideMenu)), direction: .leading)
    //    }
    //
    //    @ViewBuilder
    //    private func SideCart() -> some View {
    //        SideView(isShowing: $presentSideCart, content: AnyView(SideCartViewContents(presentSideMenu: $presentSideCart)), direction: .trailing)
    //    }
    
}

//struct CheckOutView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckoutViewNew(userId: "660675dd4c9b3ef89092f27e")
//    }
//}

//#Preview {
//    CheckoutViewNew()
//}
