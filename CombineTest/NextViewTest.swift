//
//  NextViewTest.swift
//  CombineTest
//
//  Created by sako0602 on 2023/12/14.
//

import SwiftUI

struct NextViewTest: View {
    
    @State var array: [String] = ["aa"]
    @State var showSheet = false
    @State var text = ""
    
    var body: some View {
        NavigationStack{
            List(array, id: \.self){ item in
                Text(item)
            }
            Button("sheetを開く"){
                showSheet = true
            }
            .sheet(isPresented: $showSheet, content: {//🟥値を渡しにいく。
                AddView(text: $text, showSheet: $showSheet, save: {
                    print("###")
                    
                })
            })
        }
    }
}

struct AddView: View {
    
    @Binding var text: String
    @Binding var showSheet: Bool
    let save: () -> Void //このViewが閉じた時に呼ばれる
    
    var body: some View {
        NavigationStack{
            VStack{
                TextField("入力", text: $text)
            }
            .toolbar{//🟥ボタンが押されたときに発火する。＝　画面が閉じられたとき。
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        print("####")
                        save()
                        print("####")
                        showSheet = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                    })
                }
            }
        }
    }
}


#Preview {
    NextViewTest()
}
