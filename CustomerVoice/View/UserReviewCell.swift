//
//  UserReviewCell.swift
//  CustomerVoice
//
//  Created by 윤관식 on 2021/09/22.
//

import SwiftUI



struct UserReviewCell: View {
    @Environment(\.colorScheme) var colorSchemes
    
    var userRate: Double = 4
    var userReview: UserReview
    @Binding var userReviews: [UserReview]

    var body: some View {
        NavigationLink(destination: UserReviewDetailView(userReview: userReview, userReviews: $userReviews)) {
            HStack{
                VStack {
                    Text(userReview.reviewTitle)
                        .font(.title2)
                        .fontWeight(.heavy)
                        .lineLimit(1)
                        .padding(.bottom, 5)
                    Text(userReview.reviewContext)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                .padding()
                
                Spacer()
                
                UserRateView(userReview: userReview)
                    .padding()
            }
            .foregroundColor(colorSchemes == .dark ? Color.white : Color.black)
            .background(Color.secondary.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
}

/*
struct UserReviewCell_Previews: PreviewProvider {
    static var previews: some View {
        UserReviewCell(userReview: testUserReviewDatas[1])
    }
}
*/
 

struct UserRateView: View {
    var userReview: UserReview
    
    var body: some View {
        VStack {
            Text("\(userReview.userID)님의 평가")
                .font(.footnote)
                .foregroundColor(.secondary)
            HStack{
                Text("\(String(format: "%.1f", userReview.userRate))")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                Text("/ 5")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
