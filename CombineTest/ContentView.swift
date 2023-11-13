//
//  ContentView.swift
//  CombineTest
//
//  Created by sako0602 on 2023/08/25.
//

import SwiftUI

class TextFieldValidator: ObservableObject {
    @Published var text = "" {
        didSet {
            isIdValid = !text.isEmpty // IDが空でないことをチェックするなどの検証ロジック
        }
    }
    @Published var isIdValid = false
}

struct ContentView: View {
    @StateObject private var validator = TextFieldValidator()

    var body: some View {
        TextField("Enter ID", text: $validator.text)
            .border(validator.isIdValid ? Color.green : Color.red) // 有効なら緑、無効なら赤のボーダーを表示
            .onReceive(validator.$isIdValid) { isValid in
                // IDの検証結果に基づいて何かアクションをする
                print("ID is valid: \(isValid)")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
