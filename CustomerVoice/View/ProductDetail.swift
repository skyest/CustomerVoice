//
//  ProductDetail.swift
//  CustomerVoice
//
//  Created by 윤관식 on 2021/09/22.
//

import SwiftUI
import CloudKit

struct ProductDetail: View {
    var product: Product
    @State private var selectedTabIndex: Int = 0
    @State private var userReviews: [UserReview] = []
    @State private var addNewCommentSheetVisible: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView() {
                HStack {
                    // Product Image
                    Image(uiImage: product.productImage ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200, alignment: .center)
                        .cornerRadius(10)
                    Spacer()
                    // Product ModelNo And Average User Ratings
                    VStack {
                        VStack(alignment: .leading){
                            Text("Model No")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            Text(product.modelNo)
                        }
                        .padding()
                        
                        VStack(alignment: .leading){
                            Text("평균 사용자 별점")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            HStack {
                                Text(String(format: "%.1f", getAverageUserRate(reviewList: userReviews)))
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 5)
                                Text("/ 5.0")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }

                    }
                    Spacer()
                }
                .padding()
                
                HStack {
                    Text("사용자 리뷰")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding([.top, .leading, .trailing])
                    Spacer()
                }
                
                ForEach(userReviews) { userReview in
                    UserReviewCell(userReview: userReview, userReviews: $userReviews)
                }
            }
            Button(action: {
                addNewCommentSheetVisible.toggle()
            }, label: {
                Image(systemName: "plus")
                    .font(.system(.largeTitle))
                    .frame(width: 52, height: 45)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 7)
            })
                .background(Color.purple)
                .cornerRadius(38.5)
                .padding(.all, 30)
                .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3,
                        y: 3)
            
        }
        .onAppear {
            userReviews = []
            UserReview.fetch(productModelNo: product.modelNo) { (result) in
                switch result {
                case .success(let newItem):
                    self.userReviews.append(newItem)
                    print("Successfully fetched item")
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
        .sheet(isPresented: $addNewCommentSheetVisible){
            AddNewReview(isPresented: $addNewCommentSheetVisible, userReviews: $userReviews, productModelNo: product.modelNo)
        }
        .navigationTitle(product.productName)
    }
}

func getAverageUserRate(reviewList: [UserReview]) -> Double  {
    var sum: Double = 0
    var reviewCnt = 0
    for review in reviewList {
        reviewCnt += 1
        sum += review.userRate
    }
    return Double(sum) / Double(reviewCnt)
}

/*
let testData = [
    Product(recordID: CKRecord.ID(recordName: UUID().uuidString), productName: "2021 냉장고", modelNo: "ADW-2313", productImage: nil, productType: .refrigerator)
]


struct ProductDetail_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetail(product: testData[0])
    }
}

*/
