//
//  CustomerVoiceApp.swift
//  CustomerVoice
//
//  Created by 윤관식 on 2021/09/22.
//

import SwiftUI

@main
struct CustomerVoiceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(Products())
        }
    }
}

/*
let testData2 = [
    Product(productDesc: "21년형 양문형 냉장고", productModel: "DES-3321"),
    Product(productDesc: "21년형 LG Gram", productModel: "HES-0123")
]
*/
