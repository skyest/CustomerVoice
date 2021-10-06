//
//  LoginView.swift
//  CustomerVoice
//
//  Created by 윤관식 on 2021/10/04.
//

import SwiftUI

struct LoginView: View {
    @State var userID: String = ""
    @State var userPW: String = ""
    @State var errDesc: String = ""
    @State var showAlert: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var currentUserInfo: UserInfo

    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("사용자 아이디")){
                        TextField("User ID", text: $userID)
                    }
                    Section(header: Text("비밀번호")){
                        SecureField("Passsword", text: $userPW)
                    }
                    
                    Section(header: Text(errDesc)
                                .font(.footnote)
                                .foregroundColor(Color.red)
                    ){
                        Button("로그인"){
                            errDesc = ""
                            UserInfo.isUserLoginInfoValid(userInputID: userID, userInputPW: userPW) { (isValid, userInfo, errDesc) in
                                if isValid {
                                    currentUserInfo.userID = userInfo!.userID
                                    currentUserInfo.userPW = userInfo!.userPW
                                    
                                    presentationMode.wrappedValue.dismiss()
                                }
                                else {
                                    self.errDesc = errDesc!
                                }
                                
                            }
                        }
                    }
                    
                    Section(header: Text("아직 계정이 없으신가요?")){
                        Button("회원가입"){
                            
                        }
                        .foregroundColor(.red)
                    }
                }
                .navigationTitle(Text("로그인"))
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }){
                            Image(systemName: "xmark.circle")
                        }
                    }
                }
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
