//
//  AlertTest.swift
//  CombineTest
//
//  Created by sako0602 on 2023/08/28.
//

import SwiftUI

enum LoginError: LocalizedError {
    case textError
    case passError
    case unkown
    
    var errorDescription: String?{
        switch self {
        case .textError: return "テキストエラー"
        case .passError: return "パスワードエラー"
        case .unkown: return "原因不明"
        }
    }
}

struct AlertTest: View {
    
    @State private var error: LoginError? = nil
    @State private var showAlert = false
    
    var body: some View {
        LoginView(showAlert: $showAlert, error: $error)
            .alert(isPresented: $showAlert, error: error) {
                Button("承諾した"){
                    showAlert = false
                }
            }
    }
}

struct LoginView: View {
    
    @Binding var showAlert: Bool
    @Binding var error: LoginError?
    @State private var text = ""
    @State private var pass = ""
    
    var body: some View {
        VStack{
            Text("ログイン")
            TextField("テキスト", text: $text)
                .textFieldStyle(.roundedBorder)
            TextField("パスワード", text: $pass)
                .textFieldStyle(.roundedBorder)
            Button("登録"){
                if text == ""{
                    error = .textError
                } else if pass == "" {
                    error = .textError
                }
            }
        }
        
    }
}

struct AlertTest_Previews: PreviewProvider {
    static var previews: some View {
        AlertTest()
    }
}
