//
//  AddNewCommentView.swift
//  CustomerVoice
//
//  Created by 윤관식 on 2021/09/24.
//

import SwiftUI

struct AddNewReview: View {
    //@State private var userID: String = ""
    //@State private var userPW: String = ""
    @State private var reviewTitle: String = ""
    @State private var reviewContext: String = ""
    @State private var rate: Double = 5
    @Binding var isPresented: Bool
    @Binding var userReviews: [UserReview]
    var productModelNo: String
    @EnvironmentObject var currentUserInfo: UserInfo
    
    var body: some View {
        NavigationView {
            Form{
                Section(header: Text("사용자 평가")){
                    HStack{
                        HStack {
                            Text(String(format: "%.1f", rate))
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("/ 5.0")
                                .font(.footnote)
                                .padding(.top, 5)
                                .foregroundColor(.secondary)
                            
                        }
                        Stepper(value: $rate, in: 1...5, step: 0.5){
                            
                        }
                    }
                }
                
                Section(header: Text("리뷰 제목")){
                    TextField("제목", text: $reviewTitle)
                }
                
                Section(header: Text("내용")){
                    TextEditor(text: $reviewContext)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isPresented = false
                    } label: {
                        Text("취소")
                            .padding(.all, 10.0)
                            .background(Color.orange.opacity(0.1))
                            .cornerRadius(10)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        let newItem = 
                        UserReview(recordID: nil, reviewTitle: reviewTitle, reviewContext: reviewContext, userRate: rate, userID: currentUserInfo.userID!, productModelNo: productModelNo)
                            UserReview.save(item: newItem) { (result) in
                                switch result {
                                case .success(_):
                                    self.userReviews.insert(newItem, at: 0)
                                    print("Successfully added item")
                                case .failure(let err):
                                    print(err.localizedDescription)
                                }
                            }
                        isPresented = false
                    } label: {
                        Text("Save")
                            .padding(.all, 10.0)
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(10)
                    }
                }
                
            }
            .navigationTitle("리뷰 작성하기")
        }
    }
}

/*
struct AddNewReview_Previews: PreviewProvider {
    static var previews: some View {
        AddNewReview(isPresented: .constant(true), userReviews: .constant([]))
    }
}
*/
