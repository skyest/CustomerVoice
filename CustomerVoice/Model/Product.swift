//
//  Product.swift
//  CustomerVoice
//
//  Created by 윤관식 on 2021/09/22.
//

import Foundation
import CloudKit
import UIKit

struct Product : Identifiable {
    // TODO: Main UI에서 제품 카테고리별로 정렬, 검색 기능 추가
    enum ProductType: String {
        case none = "none"
        case refrigerator = "refrigerator"
        case notebook = "notebook"
        case tv = "tv"
    }
    static let recordType = "Product"
    let id = UUID()
    let recordID: CKRecord.ID
    let productName: String
    let modelNo: String
    
    let productImage: UIImage?
    let productType: ProductType
    
    private(set) var userReviews: [UserReview]? = nil
    
    static func fetch(completion: @escaping (Result<Product, Error>) -> ()) {
        let pred = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        let query = CKQuery(recordType: recordType, predicate: pred)
        query.sortDescriptors = [sort]

        let operation = CKQueryOperation(query: query)

        operation.recordFetchedBlock = { record in
            DispatchQueue.main.async {
                let recordID = record.recordID
                guard let productName = record["productName"] as? String,
                      let modelNo = record["modelNo"] as? String
                else { return }
                var productImage: UIImage? = nil
                if let asset = record["productImage"] as? CKAsset {
                    let imageData = NSData(contentsOf: asset.fileURL!)
                    productImage = UIImage(data: imageData! as Data)
                }
                let product = Product(recordID: recordID, productName: productName, modelNo: modelNo, productImage: productImage, productType: .none)
                completion(.success(product))
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
    
}

class Products: ObservableObject {
    @Published var items: [Product] = []
}

