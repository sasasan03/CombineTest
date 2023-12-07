//
//  PublishTest.swift
//  CombineTest
//
//  Created by sako0602 on 2023/12/06.
//

import SwiftUI
import Combine

struct PublishTest: View {
    
    let subject: PassthroughSubject<Int,Never>
    let cancellable: AnyCancellable
    
    init(){
        self.subject = PassthroughSubject<Int,Never>()
        self.cancellable = subject.sink { completion in
            print(completion)
        } receiveValue: { value in
            print(value)
        }
    }
    
    var body: some View {
        VStack{
            Button("値を流すボタン"){
                subject.send(1)
                subject.send(2)
                subject.send(3)
            }
            Button("cancelボタン"){
                cancellable.cancel()
            }
        }
        
    }
}

#Preview {
    PublishTest()
}
