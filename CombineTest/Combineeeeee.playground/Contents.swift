import Foundation
import Combine
import UIKit

//-------------------------------あきおさんの動画

struct Person{
    var name: String//🟦varで宣言
    var age: Int
}

var sako = Person(name: "sako", age: 30)
//キーパスを使ってインスタンスの要素を取り出す。
let nameKeyPath: WritableKeyPath<Person, String> = \Person.name
let ageKeyPath: WritableKeyPath<Person, Int> = \Person.age

sako[keyPath: nameKeyPath] = "hiro"
sako[keyPath: ageKeyPath] = 19

class ViewModel {
    var number = 0
}

let viewModel = ViewModel()
let publisher = [1,2,3].publisher

//assignを使わない書き方
publisher.sink { number in //🟥やりたいことは流れてきたnumberをViewModelに設定したい。
    viewModel.number = number
    print(viewModel.number)
}
//assignを使った書き方。KeyPathを使って値を流し込む。
let subscription = publisher.assign(to: \.number, on: viewModel)








//let aaa  = [1,2,3].publisher
//aaa.sink { int in
//    print(int)
//}
//
//let subject = PassthroughSubject<Int,Never>()
//
//var set = Set<AnyCancellable>()
//
//set.insert(subject.sink { value in
//    print("A",value)
//})
//
//subject.send(10)
//subject.send(20)
//subject.send(30)
//
//subject.sink { value in  //管に値を送る。
//    print("C", value)
//}.store(in: &set) //setに対してinsertする





//let subject = PassthroughSubject<Int,Never>()
//
////var array: [AnyCancellable] = []
//var set = Set<AnyCancellable>()
//
//let aaa = subject.sink { value in
//    print("A",value)
//}
//
//set.insert(aaa)
//set.insert(aaa)
//
//set.count //1
//
//set.insert(subject.sink { value in
//    print("B",value)
//})
//
//set.count //2
//
//subject.send(10)
//
//set.forEach{
//    print("cancel")
//    $0.cancel()
//}
//
//subject.send(20)
//subject.send(30)








//let subject = PassthroughSubject<Int,Never>()
//
//let aaa = subject.sink { value in
//    print("A",value)
//}
//
//let bbb = subject.sink { value in
//    print("B",value)
//}
//
//subject.send(10)//A,B
//aaa.cancel()
//subject.send(20)//B
//subject.send(30)//B


//３章〜〜〜〜〜〜〜〜〜〜〜〜〜〜　イベントの送信


//let publisher = Timer.publish(every: 1, on: .main, in: .common)
//
//final class Receiver {
//    var subscriptions = Set<AnyCancellable>()
//    
//    init(){
//        publisher
//            .sink { data in
//                print(data)
//            }.store(in: &subscriptions)
//    }
//}
//
//let receiver = Receiver()
//publisher.connect()



//let publisher = ["🍎","🍌","🍊","🍇"].publisher
//
//final class Reciver {
//    var subscription = Set<AnyCancellable>()
//    
//    init(){
//        publisher
//            .sink { completion in
//                print(completion)
//            } receiveValue: { value in
//                print(value)
//            }
//            .store(in: &subscription)
//    }
//}
//
//let reciver = Reciver()





//２章〜〜〜〜〜〜〜〜〜〜〜〜〜〜　送受信を分けてみる


//🟥assign

//let subject = PassthroughSubject<String,Never>()
//
//final class SomeObject {
//    var value: String = "" {
//        didSet {
//            print("didSet value", value)
//        }
//    }
//}
//
//final class Receiver {
//    var subscription = Set<AnyCancellable>()
//    let object = SomeObject()
//    
//    init(){
//        subject
//            .assign(to: \.value, on: object)
//            .store(in: &subscription)
//    }
//    
//}
//
//let receiver = Receiver()
//subject.send("🍎")
//subject.send("🍌")
//subject.send("🍊")
//subject.send("🍇")







//Set型を使ってまとめて管理する

//let subject = PassthroughSubject<String,Never>()
//
//final class Reciver {
//    var subscription = Set<AnyCancellable>()
//    
//    init(){
//        subject
//            .sink { value in
//                print("sub1",value)
//            }.store(in: &subscription)
//        subject
//            .sink { value in
//                print("sub2",value)
//            }.store(in: &subscription)
//        subject
//            .sink { completion in
//                print(completion)
//            } receiveValue: { value in
//                print("sub3",value)
//            }.store(in: &subscription)
//
//    }
//}
//let receiver = Reciver()
//subject.send("🍎")
//subject.send("🍌")
//subject.send("🍊")
//subject.send("🍇")







//let subject = PassthroughSubject<String,Never>()
//
//final class Reciver {
//    let subscription1:AnyCancellable
//    let subscription2:AnyCancellable
//    
//    init(){
//        //🟦sinkの戻り値はAnyCanellable型。この型に適合したプロパティで保存する。
//        subscription1 = subject
//            .sink { value in
//                print("sub1",value)
//            }
//        subscription2 = subject
//            .sink(receiveValue: { value in
//                 print("sub2", value)
//            })
//    }
//}
//let receiver = Reciver()
//subject.send("🍎")
//subject.send("🍌")
//receiver.subscription1.cancel()
//subject.send("🍊")
//subject.send("🍇")




//🟥値の出力を行う
//let subject = PassthroughSubject<String,Never>()
//
//final class Reciver {
//    let subscription1:AnyCancellable
//    
//    init(){
//        //🟦sinkの戻り値はAnyCanellable型。この型に適合したプロパティで保存する。
//        subscription1 = subject
//            .sink { value in
//                print(value)
//            }
//    }
//}
//let receiver = Reciver()
//subject.send("sa")
//receiver.subscription1.cancel()
//subject.send("ko")
//subject.send("da")


//🟥値の出力を行える
//let subject = PassthroughSubject<String,Never>()
//
//final class Reciver {
//
//    init(){
//        subject
//            .sink { value in
//                print(value)
//            }
//    }
//}
//
//let receiver = Reciver()
//subject.send("sa")
//subject.send("ko")
//subject.send("da")




//１章〜〜〜〜〜〜〜〜〜〜〜〜〜〜　送受信をまとめて行う

//let subject = PassthroughSubject<String,Never>()
//
//subject.sink { completion in
//    print("Com",completion)
//} receiveValue: { value in
//    print("Va",value)
//}
//subject.send("あ")
//subject.send("い")
//subject.send("う")
//subject.send(completion: .finished)



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



//class Temperture {
//    var value: Int
//    init(value: Int) {
//        self.value = value
//    }
//}
//
//class Wether {
//    @Published var temperture: Temperture = Temperture(value: 1)
//}
//
//let wether = Wether()
//_ = wether.$temperture
//    .sink {
//        print("\($0.value)")
//    }
//
//wether.temperture.value = 2 //直接のアクセスは不可能
//print("温度終了")






//class ViewModel {
//    var number:Int = 0
//}
//
//var cancellable = Set<AnyCancellable>()
//let viewModel = ViewModel()
//let publisher = [1,2,3].publisher
//publisher.assign(to: \.number, on: viewModel)
//    .store(in: &cancellable)
//print("🟥",viewModel.number)//３






//class ViewModel {
//    var number:Int = 0
//}
//
//let viewModel = ViewModel()
//let publisher = [1,2,3].publisher
//let subscription = publisher.assign(to: \.number, on: viewModel)
////キーパスの値型 '[Int]' をコンテキスト型 'Publishers.Sequence<[Int], Never>.Output' (別名 'Int') に変換できません。
//print("🟥",viewModel.number)






//var cancellables = Set<AnyCancellable>()
//
//let publisher = [1,2,3].publisher
//publisher.sink(receiveCompletion: { finished in
//    print("🟥receive：\(finished)")
//}, receiveValue: { value in
//    print("🟦value：\(value)")
//}) .store(in: &cancellables)





//let publisher = [1,2,3].publisher
//let subscription = publisher.sink(receiveCompletion: { finished in
//    print("🟥receive：\(finished)")
//}, receiveValue: { value in
//    print("🟦value：\(value)")
//})
    



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
