//
//  UserReviewDetailView.swift
//  CustomerVoice
//
//  Created by 윤관식 on 2021/09/22.
//

import SwiftUI

struct UserReviewDetailView: View {
    var userReview: UserReview
    @EnvironmentObject var currentUserInfo: UserInfo
    @Binding var userReviews: [UserReview]
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                GroupBox(label: Text(userReview.reviewTitle).font(.title).fontWeight(.bold)) {
                    HStack {
                        Spacer()
                        UserRateViewHorizontal(userID: userReview.userID, userRate: userReview.userRate)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.trailing, 30)
                    }
                    
                    Text(userReview.reviewContext)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical)
                }
                .cornerRadius(20)
                .padding()
                
                Spacer()
            }
            // show buttons only when user info matches
            if userReview.userID == currentUserInfo.userID {
                HStack {
                    Button(action: {
                        guard let recordID = userReview.recordID else { return }
                        UserReview.delete(recordID: recordID) { (result) in
                            switch result {
                            case .success(let recordID):
                                self.userReviews.removeAll { (userReview) -> Bool in
                                    return userReview.recordID == recordID
                                }
                                print("Successfully deleted item")
                            case .failure(let err):
                                print(err.localizedDescription)
                            }
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "trash")
                            .font(.system(.largeTitle))
                            .frame(width: 65, height: 60)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 7)
                    })
                        .background(Color.red.opacity(0.7))
                        .cornerRadius(38.5)
                        .padding(.all, 30)
                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3,
                                y: 3)                    
                    Spacer()
                    Button(action: {
                        // TODO: 리뷰 편집 기능 구현 필요(회원관리 기능 이후 구현 예정)
                    }, label: {
                        Image(systemName: "square.and.pencil")
                            .font(.system(.largeTitle))
                            .frame(width: 65, height: 60)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 7)
                    })
                        .background(Color.blue.opacity(0.7))
                        .cornerRadius(38.5)
                        .padding(.all, 30)
                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3,
                                y: 3)

                }
            }
        }
    }
}

/*
struct UserReviewDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserReviewDetailView(userReview: UserReview(recordID: nil, reviewTitle: "에어컨이 시원하고 좋아요", reviewContext: "가나다라마바사", userRate: 3.5, userID: "asfsaf"), userReviews: .constant([]) )
    }
}
*/

struct UserRateViewHorizontal: View {
    var userID: String
    var userRate: Double
    
    var body: some View {
        HStack {
            Text("\(userID)님의 평가")
                .font(.subheadline)
                .foregroundColor(.secondary)
            HStack{
                Text("\(String(format: "%.1f", userRate))")
                    .font(.headline)
                    .fontWeight(.bold)
                Text("/ 5")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
