//
//  CombineTestView.swift
//  CombineTest
//
//  Created by sako0602 on 2023/12/04.
//

import SwiftUI
import Combine

class Model {
//    @Published var num1 = 0
    let subject = PassthroughSubject<String,Never>()
}

//class ViewModel {
//    var numText = ("","") {
//        didSet {
//            print("numText", numText)
//        }
//    }
//}



struct CombineTestView: View {
    var subject = PassthroughSubject<Int,Never>()
    @State var set = Set<AnyCancellable>()
//    let model = Model()
    @State var numberText = "init"
    init(){
        subject.sink { int in
            print("🟥",int)
        }.store(in: &set)
    }
    
    var body: some View {
        VStack{
            Button("注入"){
                subject.sink { value in
                    numberText = String(value)
                }
                .store(in: &set)
//                subject.send(1)
//                subject.send(2)
//                subject.send(3)
            }.padding()
            Button("購読"){
                subject.send(100)
            }.padding()
            Button("Cancelボタン"){
                set.forEach { cancel in
                    cancel.cancel()
                }
            }.padding()
            Text(numberText)
                .font(.title3)
                .fontWeight(.heavy)
        }
    }
}

#Preview {
    CombineTestView()
}
