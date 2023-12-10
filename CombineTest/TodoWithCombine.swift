//
//  TodoWithCombine.swift
//  CombineTest
//
//  Created by sako0602 on 2023/12/05.
//

import SwiftUI
import Combine

//@Published var todos: [TodoEntity] = [
//    TodoEntity(item: "勉強", isChecked: false),
//    TodoEntity(item: "洗濯", isChecked: false),
//    TodoEntity(item: "顔を洗う", isChecked: false)
//]

struct TodoEntity: Identifiable {
    let id = UUID()
    let item: String
    let isChecked: Bool
}

//値を流すクラスと値を受けとるクラスに分けたい

//⭐️値を流すクラス
class TodoViewModel: ObservableObject{
    //値を出力する
    @Published var numbers = [1,2,3,4]
    //値を保持させる
    var set = Set<AnyCancellable>()
    
    func appendText(_ todo: String){
        
    }
}

//⭐️値を受けとるクラス
struct TodoWithCombine: View {
    
    @StateObject var todoViewModel: TodoViewModel = TodoViewModel()
    @State private var text = ""
    
    init(){
        let _ = print("###",todoViewModel.numbers)
        todoViewModel.$numbers
            .sink { numbers in
                print(numbers)
            }
            .store(in: &todoViewModel.set)
    }
    
    var body: some View {
        VStack{
            List(todoViewModel.numbers, id: \.self){ number in
                Text("\(number)")
            }
            HStack{
                TextField("入力", text: $text)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                //ボタンを押して値を注入させる
                Button("numbersに追加"){
                    todoViewModel.numbers.append(Int(text) ?? 0)
                    print("%%%",todoViewModel.numbers.count)
                }.padding()
            }.padding()
            Button("キャンセル"){
                print("$$$", todoViewModel.set.count)
                todoViewModel.set.forEach{ number in
                    number.cancel()
                }
            }.padding()
        }
    }
}

#Preview {
    TodoWithCombine()
}
