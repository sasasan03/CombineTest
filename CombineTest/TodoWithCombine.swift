//
//  TodoWithCombine.swift
//  CombineTest
//
//  Created by sako0602 on 2023/12/05.
//

import SwiftUI
import Combine

class TodoModel{
    @Published var todos: [String] = []
}

struct TodoWithCombine: View {
    
    @State private var text = ""
    let set = Set<AnyCancellable>()
    
    var body: some View {
        VStack{
            List{
                
            }
            HStack{
                TextField("入力", text: $text)
                Button("TODOに追加"){
                    
                }
            }
            
        }
        
        
        Text("Hello, World!")
    }
}

#Preview {
    TodoWithCombine()
}
