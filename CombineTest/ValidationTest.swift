//
//  ValidationTest.swift
//  CombineTest
//
//  Created by sako0602 on 2023/12/24.
//

import SwiftUI
import Combine

struct ValidationTest: View {
    @State private var name = ""
    
    
    var body: some View {
        Text("プルリクエストのために作成")
        Text("プッシュ後に追加したText")
        Text("マージ後に追加したText")
    }
}

#Preview {
    ValidationTest()
}
