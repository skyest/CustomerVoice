//
//  UserInfo.swift
//  CustomerVoice
//
//  Created by 윤관식 on 2021/10/04.
//

import Foundation
import CloudKit
import SwiftUI

class UserInfo : Identifiable, ObservableObject {
    enum UserPermission: String {
        case normal = "normal"
        case admin = "admin"
    }
    
    static let recordType = "UserInfo"
    let id = UUID()
    //let recordID: CKRecord.ID? = nil
    @Published var userID: String?
    var userPW: String?
    
    init(){}
    init(userID: String, userPW: String) {
        self.userID = userID
        self.userPW = userPW
    }
    
    
    static func isUserLoginInfoValid(userInputID: String, userInputPW: String, _ completion: @escaping (Bool, UserInfo?, String?) -> ()) {
        let predicate = NSPredicate(format: "userID == %@", userInputID)
        //let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        let query = CKQuery(recordType: recordType, predicate: predicate)
        //query.sortDescriptors = [sort]
        
        let operation = CKQueryOperation(query: query)

        operation.recordFetchedBlock = { record in
            DispatchQueue.main.async {
                //let recordID = record.recordID
                guard let userID = record["userID"] as? String else { return }
                guard let userPW = record["userPW"] as? String else { return }
                let userInfo: UserInfo?
                if userPW == userInputPW {
                    userInfo = UserInfo(userID: userID, userPW: userPW)
                    completion(true, userInfo, nil)
                } else {
                    completion(false, nil, "Invalid Password")
                }
            }
        }
        
        operation.queryCompletionBlock = { (cursor , err) in
            DispatchQueue.main.async {
                if let err = err {
                    completion(false, nil, err.localizedDescription)
                    return
                }
            }
        }
        CKContainer.default().publicCloudDatabase.add(operation)
    }
}
