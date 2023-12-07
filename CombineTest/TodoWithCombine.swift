//
//  TodoWithCombine.swift
//  CombineTest
//
//  Created by sako0602 on 2023/12/05.
//

import SwiftUI
import Combine

//class TodoViewModel: ObservableObject{
//    @Published var todos: [String] = ["AAA"]
//    
//    private var set = Set<AnyCancellable>()
//    
//    deinit {
//        set.forEach{ element in
//            element.cancel()
//        }
//    }
//    
//    func appendText(_ todo: String){
//        todos
//    }
//    
//}

struct TodoWithCombine: View {
    
//    @StateObject private var vm = TodoViewModel()
//    @State private var text = ""
    
    var body: some View {
        Text("aa")
//        VStack{
//            List(vm.todos, id: \.self){ todo in
//                Text(todo)
//            }
//            HStack{
//                TextField("入力", text: $text)
//                    .textFieldStyle(.roundedBorder)
//                Button("TODOに追加"){
//                    vm.appendText(text)
//                }.padding()
//            }
//            
//        }
    }
}

#Preview {
    TodoWithCombine()
}
