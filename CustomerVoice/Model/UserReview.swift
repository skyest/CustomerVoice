//
//  UserReview.swift
//  CustomerVoice
//
//  Created by 윤관식 on 2021/09/22.
//

import Foundation
import CloudKit

/*
let testUserReviewDatas = [
    UserReview(reviewTitle: "시원하고 좋아요", reviewContext: "1년정도 썼는데 시원하고 좋아요, 내년에 딸아이 의견 들어 보고 재구매 의사 있어요", userRate: 3, userID: "abc1234"),
    UserReview(reviewTitle: "생각보다 괜찮아요", reviewContext: "1년정도 썼는데 시원하고 좋아요, 근데 제습 기능이 가끔 잘 안 될 때가 있어요", userRate: 3.5, userID: "handsumGuy"),
    UserReview(reviewTitle: "굿굿", reviewContext: "나의 살던 고향은 꽃 피는 산골, 우리 산골에도 에어컨 하나만 놔 주세요", userRate: 5, userID: "mynameis123"),
    UserReview(reviewTitle: "배송이 느려요", reviewContext: "상품은 좋은데 배송이 느려오", userRate: 4, userID: "asdf1123"),
    UserReview(reviewTitle: "시원하고 좋아요", reviewContext: "1년정도 썼는데 시원하고 좋아요", userRate: 5, userID: "seoul4324"),
    UserReview(reviewTitle: "시원하고 좋아요", reviewContext: "오래 쓸게요 감사합니다 그런데 서비스로 주신 그건 좀...", userRate: 3, userID: "purple0183")
]
*/


struct UserReview: Identifiable {
    let id = UUID()
    let recordID: CKRecord.ID?
    //private let id: CKRecord.ID
    let reviewTitle: String
    let reviewContext: String
    let userRate: Double
    let userID: String
    var productModelNo: String = ""
    static let recordType = "userReview"

    enum CloudKitHelperError: Error {
        case recordFailure
        case recordIDFailure
        case castFailure
        case cursorFailure
    }
    
    static func fetch(productModelNo: String, completion: @escaping (Result<UserReview, Error>) -> ()) {
        let pred = NSPredicate(format: "productModelNo == %@", productModelNo)

        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        let query = CKQuery(recordType: recordType, predicate: pred)
        query.sortDescriptors = [sort]

        let operation = CKQueryOperation(query: query)

        operation.recordFetchedBlock = { record in
            DispatchQueue.main.async {
                let recordID = record.recordID
                guard let reviewTitle = record["reviewTitle"] as? String,
                      let reviewContext = record["reviewContext"] as? String,
                      let userRate = record["userRate"] as? Double,
                      let userID = record["userID"] as? String
                else { return }
                let userReview = UserReview(recordID: recordID, reviewTitle: reviewTitle, reviewContext: reviewContext, userRate: userRate, userID: userID)
                completion(.success(userReview))
            }
        }
        
        operation.queryCompletionBlock = { (_, err) in
            DispatchQueue.main.async {
                if let err = err {
                    completion(.failure(err))
                    return
                }
            }
        }
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    static func save(item: UserReview, completion: @escaping (Result<UserReview, Error>) -> ()) {
        let itemRecord = CKRecord(recordType: recordType)
        
        itemRecord["reviewTitle"] = item.reviewTitle as CKRecordValue
        itemRecord["reviewContext"] = item.reviewContext as CKRecordValue
        itemRecord["userRate"] = item.userRate as CKRecordValue
        itemRecord["userID"] = item.userID as CKRecordValue
        itemRecord["productModelNo"] = item.productModelNo as String

        CKContainer.default().publicCloudDatabase.save(itemRecord) { (record, err) in
            DispatchQueue.main.async {
                if let err = err {
                    completion(.failure(err))
                    return
                }
                guard let record = record else {
                    completion(.failure(CloudKitHelperError.recordFailure))
                    return
                }
                let recordID = record.recordID
                guard let reviewTitle = record["reviewTitle"] as? String,
                      let reviewContext = record["reviewContext"] as? String,
                      let userRate = record["userRate"] as? Double,
                      let userID = record["userID"] as? String,
                      let productModelNo = record["productModelNo"] as? String
                else {
                    completion(.failure(CloudKitHelperError.castFailure))
                    return
                }
                let userReview = UserReview(recordID: recordID, reviewTitle: reviewTitle, reviewContext: reviewContext, userRate: userRate, userID: userID, productModelNo: productModelNo)
                completion(.success(userReview))
            }
        }
    }
    
    static func delete(recordID: CKRecord.ID, completion: @escaping (Result<CKRecord.ID, Error>) -> ()) {
        CKContainer.default().publicCloudDatabase.delete(withRecordID: recordID) { (recordID, err) in
            DispatchQueue.main.async {
                if let err = err {
                    completion(.failure(err))
                    return
                }
                guard let recordID = recordID else {
                    completion(.failure(CloudKitHelperError.recordIDFailure))
                    return
                }
                completion(.success(recordID))
            }
        }
    }
}

    
