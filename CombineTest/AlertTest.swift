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
    case unknownError
    
    var errorDescription: String?{
        switch self {
        case .textError: return "テキストエラー"
        case .passError: return "パスワードエラー"
        case .unknownError: return "原因不明"
        }
    }
}

struct AlertTest: View {
    
    @State private var error: LoginError? = nil
    @State private var showAlert = false
    
    var body: some View {
        LoginView(showAlert: $showAlert, error: $error)
            .alert(isPresented: $showAlert, error: error) {
                Button("あいよ！！"){
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
            Text("Login View")
                .font(.largeTitle)
            TextField("テキスト", text: $text)
                .textFieldStyle(.roundedBorder)
            TextField("パスワード", text: $pass)
                .textFieldStyle(.roundedBorder)
            Button("登録"){
                guard text.count != 0 else {
                    showAlert = true
                    error = .textError
                    return
                }
                guard pass.count != 0 else {
                    showAlert = true
                    error = .textError
                    return
                }
                //...firebase ログイン処理
            }
        }
        .padding()
    }
}

struct AlertTest_Previews: PreviewProvider {
    static var previews: some View {
        AlertTest()
    }
}
