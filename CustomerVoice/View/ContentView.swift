//
//  ContentView.swift
//  CustomerVoice
//
//  Created by 윤관식 on 2021/09/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var products: Products
    @EnvironmentObject var currentUserInfo: UserInfo
    
    @State private var selectedProductCategory = ""
    @State private var showCategorySelectSheet = false
    @State private var showLoginSheet = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(products.items) { product in
                    productCell(product: product)
                }
                
                HStack {
                    Spacer()
                    Text("\(products.items.count) Products")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("모든 상품")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: {showLoginSheet.toggle()}) {
                        if currentUserInfo.userID == nil {
                            HStack{
                                Image(systemName: "person.crop.circle.badge.questionmark")
                                Text("로그인")
                                    .font(.subheadline)
                            }
                        }
                        else {
                            Image(systemName: "person.circle")
                            Text("\(currentUserInfo.userID!) 님 환영합니다")
                                .font(.subheadline)
                        }
                    }
                    .padding(.horizontal, 5)
                    .background(currentUserInfo.userID == nil ?
                                Color.yellow.opacity(0.4) : Color.green.opacity(0.4))
                    .cornerRadius(10)

                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {showCategorySelectSheet.toggle()}) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                    }
                }
            }
            .onAppear {
                Product.fetch { (result) in
                    switch result {
                    case .success(let newItem):
                        self.products.items.append(newItem)
                        print("Successfully fetched item")
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                }
            }
            .sheet(isPresented: $showLoginSheet){
                LoginView()
            }
            .sheet(isPresented: $showCategorySelectSheet){
                //TODO : 제품군으로 Filter 기능 구현 필요
                Text("Filter")
                
            }
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static let products = Products()
        static var previews: some View {
            ContentView()
                .environmentObject(products)
                .environmentObject(UserInfo())
        }
    }
    
    
    struct productCell: View {
        var product: Product
        
        var body: some View {
            NavigationLink(destination: ProductDetail(product: product)) {
                HStack {
                    Image(uiImage: product.productImage ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                        .padding(.all, 5)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading) {
                        Text(product.productName)
                            .lineLimit(1)
                        Text(product.modelNo)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}
