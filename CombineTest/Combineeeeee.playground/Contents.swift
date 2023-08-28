import Foundation
import Combine


//--------------------------------------------------------------------
//let cancellable: AnyCancellable
//
//let myRange = (0...3)
//cancellable = myRange.publisher//🍟mayRangeはただのオブジェクト。myRange.publisherでPubklisherになる。
//    .sink(receiveCompletion: { print ("completion: \($0)") },
//          receiveValue: { print ("value: \($0)") })

//--------------------------------------------------------------------
//var cancellable = Set<AnyCancellable>()
//let pubishers = [Just("やっほー"),Just("やほー"),Just("ヤー")]
//
//pubishers.forEach { publish in
//    publish.sink { completion in
//        switch completion {
//        case .finished:
//            sleep(3)
//            print("データ取得完了")
//        case .failure(let error):
//            print("エラー：\(error)")
//        }
//    } receiveValue: { value in
//        sleep(3)
//        print("バリュー:\(value)")
//        print("キャンセレイブル：\(cancellable.count)")
//    }
//    .store(in: &cancellable)
//    print("🍔キャンセレイブル：\(cancellable.count)")
//}

//--------------------------------------------------------------------

//let subscriber = pubisher.sink { completion in
//    print("🍔１")
//    switch completion {
//    case .finished:
//        sleep(3)
//        print("データ取得完了")
//    case .failure(let error):
//        sleep(3)
//        print("エラー：\(error)")
//    }
//    print("🍔３")
//} receiveValue: { value in
//    sleep(3)
//    print("受け取ったバリュー：\(value)")
//}

//--------------------------------------------------------------------
//PassthroughSubject
//<<Class>>final class PassthroughSubject<Output, Failure> where Failure : Error

//--------------------------------------------------------------------
// 簡略化されたPublisherプロトコル
protocol SimplePublisher {
    associatedtype Output
    associatedtype Failure: Error
}

// Intを出力する可能性があり、Neverエラーを出さないパブリッシャー
struct IntPublisher: SimplePublisher {
    typealias Output = Int
    typealias Failure = Never
}

// Stringを出力する可能性があり、特定のエラーを持つパブリッシャー
enum SomeError: Error {
    case exampleError
}

struct StringPublisher: SimplePublisher {
    typealias Output = String
    typealias Failure = SomeError
}

struct CombineLatest<A: SimplePublisher, B: SimplePublisher> where A.Failure == B.Failure {
    let publisherA: A
    let publisherB: B
    
    // この中での処理を書く
}


//struct AnotherIntPublisher: SimplePublisher {
//    typealias Output = Int
//    typealias Failure = SomeError // StringPublisherと同じFailure型
//}
//
//// これは許可される
//let validCombined = CombineLatest(publisherA: StringPublisher(), publisherB: AnotherIntPublisher())
//
////--------------------------------------------------------------------
//let pub1 = PassthroughSubject<Int, Never>()
//let pub2 = PassthroughSubject<Int, Never>()
//var cancellable: AnyCancellable
//
//cancellable = pub1.combineLatest(pub2).sink { print("Result: \($0).") }
//
//pub1.send(1)
//pub1.send(2)
//pub2.send(2)
//pub1.send(3)
//pub1.send(45)
//pub2.send(22)
