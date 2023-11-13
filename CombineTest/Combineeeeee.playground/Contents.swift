import Foundation
import Combine
import UIKit



// Publisherプロトコルに準拠するための独自のパブリッシャークラス
//struct SimplePublisher: Publisher {
//    
//    typealias Output = Int
//    typealias Failure = Never
//
//    let numbers: [Int]
//
//    // Subscriberに接続するためのメソッド
//    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Int == S.Input {
//        print("🟥receive")
//        // 配列の各要素を順に発行するシーケンスを作成
//        let sequence = numbers.enumerated().map { index, number in
//            // インデックスに遅延をつけることで、非同期的な挙動を模倣する
//            Just(number).delay(for: .seconds(index), scheduler: RunLoop.main)
//        }
//        // 作成したシーケンスをMergeManyで一つのパブリッシャーに統合
//        let merged = Publishers.MergeMany(sequence)
//        // サブスクライバーに接続
//        merged.subscribe(subscriber)
//    }
//}

//// 独自のパブリッシャーを使用
//let simplePublisher = SimplePublisher(numbers: [1, 2, 3, 4, 5])
//
//// サブスクライバーを追加してコンソールに出力
//let subscription = simplePublisher
//    .sink(receiveCompletion: { completion in
//        switch completion {
//        case .finished:
//            print("Finished emitting numbers.")
//        case .failure(let error):
//            print("An error occurred: \(error)")
//        }
//    }, receiveValue: { number in
//        print(number)
//    })



//----------------------------------------------------------------
//⭐️sinkのサンプルコード
//let integers = (0...3)
//integers.publisher
//    .sink { print("Received \($0)") }
// Prints:
//  Received 0
//  Received 1
//  Received 2
//  Received 3

//----------------------------------------------------------------
//⭐️mapのサンプルコード
//var cancellable = AnyCancellable({})
//let numbers = [5, 4, 3, 2, 1, 0]
//let romanNumeralDict: [Int : String] =
//   [1:"I", 2:"II", 3:"III", 4:"IV", 5:"V"]
//cancellable = numbers.publisher
//    .map { romanNumeralDict[$0] ?? "(unknown)" }
//    .sink { print("\($0)", terminator: " ") }

//----------------------------------------------------------------
//⭐️combineLatestのサンプルコード
//var cancellable = AnyCancellable({}) //これが大切になってくる
//
//let pub1 = PassthroughSubject<Int, Never>()
//let pub2 = PassthroughSubject<Int, Never>()
//
//cancellable = pub1
//    .combineLatest(pub2)
//    .sink { print("Result: \($0).") }
//
//pub1.send(1)//1,?　タプルを作成できない
//pub1.send(2)//2,?　上流から値を受けとり、値を更新する
//pub2.send(2)//2,2
//pub1.send(3)//3,2
//pub1.send(45)//45,2
//pub2.send(22)//45,22

//----------------------------------------------------------------
//⭐️⭐️勉強会のサンプルコード
//let a = CurrentValueSubject<Int,Never>(3)
//let b = Just(1)
//
//let publisher = b.combineLatest(a).map { b, a  in
//    a + b
//}
//
//publisher.sink { added in
//    print(added)
//}
//
//a.send(10)

//-----------------------------------------------------------おしまい








//🟦Publisher：イベントを発行
//型が時間の経過とともに一連の値を送信できることを宣言する。
//let publisher = ["A","B","C"].publisher
//
////
//publisher.sink { str in
//    print(str)
//}





////🟦Subscriber：イベントを受け取って処理を行う
//let subject = PassthroughSubject<String,Never>()
//
//subject.send("もも")
//
////🟡sink：
//subject.sink { completion in
//    print("コンプリージョン",completion)
//} receiveValue: { str in
//    print("バリュー",str)
//}
//
//subject.send("A")
//
//subject.send("B")
//
//subject.send(completion: .finished)
//
//subject.send("C")














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
//protocol SimplePublisher {
//    associatedtype Output
//    associatedtype Failure: Error
//}
//
//// Intを出力する可能性があり、Neverエラーを出さないパブリッシャー
//struct IntPublisher: SimplePublisher {
//    typealias Output = Int
//    typealias Failure = Never
//}
//
//// Stringを出力する可能性があり、特定のエラーを持つパブリッシャー
//enum SomeError: Error {
//    case exampleError
//}
//
//struct StringPublisher: SimplePublisher {
//    typealias Output = String
//    typealias Failure = SomeError
//}
//
//struct CombineLatest<A: SimplePublisher, B: SimplePublisher> where A.Failure == B.Failure {
//    let publisherA: A
//    let publisherB: B
//    
//    // この中での処理を書く
//}
//
//
////struct AnotherIntPublisher: SimplePublisher {
////    typealias Output = Int
////    typealias Failure = SomeError // StringPublisherと同じFailure型
////}
////
////// これは許可される
////let validCombined = CombineLatest(publisherA: StringPublisher(), publisherB: AnotherIntPublisher())
////
//////--------------------------------------------------------------------
////let pub1 = PassthroughSubject<Int, Never>()
////let pub2 = PassthroughSubject<Int, Never>()
////var cancellable: AnyCancellable
////
////cancellable = pub1.combineLatest(pub2).sink { print("Result: \($0).") }
////
////pub1.send(1)
////pub1.send(2)
////pub2.send(2)
////pub1.send(3)
////pub1.send(45)
////pub2.send(22)
