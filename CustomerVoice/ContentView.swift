//
//  ContentView.swift
//  CustomerVoice
//
//  Created by 윤관식 on 2021/09/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var products: Products

    @State private var selectedProductCategory = ""
    @State private var showCategorySelectSheet = false
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
        .sheet(isPresented: $showCategorySelectSheet){
            //TODO : 제품군으로 Filter 기능 구현 필요
            Text("Filter")
            
        }
    }
}

/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(products: )
    }
}
 */

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
