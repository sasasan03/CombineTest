import Foundation
import Combine
import Combine
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
    
    // この中での処理...
}

// これはコンパイルエラーとなる
// let combined = CombineLatest(publisherA: IntPublisher(), publisherB: StringPublisher())

// しかし、もし`IntPublisher`と同じエラー型を持つ別のパブリッシャーを作成すれば、
// その組み合わせは許可されるでしょう。

struct AnotherIntPublisher: SimplePublisher {
    typealias Output = Int
    typealias Failure = SomeError // StringPublisherと同じFailure型
}

// これは許可される
let validCombined = CombineLatest(publisherA: StringPublisher(), publisherB: AnotherIntPublisher())

//--------------------------------------------------------------------
let pub1 = PassthroughSubject<Int, Never>()
let pub2 = PassthroughSubject<Int, Never>()
let pub3 = PassthroughSubject<String, Never>()
let pub4 = PassthroughSubject<String, Never>()

var cancellable: AnyCancellable

cancellable = pub3
    .combineLatest(pub4)
    .sink{ print("Result: \($0)")}

cancellable = pub1
    .combineLatest(pub2)
    .sink { print("Result: \($0).") }

pub3.send("さこ")
pub3.send("行田")
pub4.send("ひろ")
pub1.send(1)
pub1.send(2)
pub2.send(2)
pub1.send(3)
pub1.send(45)
pub2.send(22)

                <Int>(Int) -> Publishers.CombineLatest<Self, Int> where Int : Publisher, Self.Failure == Int.Failure
func combineLatest<P>(_ other: P) -> Publishers.CombineLatest<Self, P> where P : Publisher, Self.Failure == P.Failure
                                         struct CombineLatest<A, B> where A : Publisher, B : Publisher, A.Failure == B.Failure

//-----------------------------
// 1. let b = B(a)
//struct A {
//    let value: Int
//}
//
//struct B {
//    let value : A
//    init( _ value: A){
//        self.value = value
//    }
//}
//
//let a = A(value: 10)
//let b = B(a)
//---------------------------------------
//2. let b = convert(from: a)
//struct A {
//    let value: Int
//}
//
//struct B {
//    var value : Int
//}
//
//func convert(from a: A) -> B {
//    B(value: a.value)
//}
//let a = A(value: 10)
//let b = convert(from: a)
//---------------------------------------
// 3. let b = a.convertToB()

//struct A {
//    var value: Int
//    func convertToB() -> B{
//        B(value: self.value)
//    }
//}
//
//struct B {
//    let value : Int
//}
//
//let a = A(value: 30)
//let b = a.convertToB()

//---------------------------------------

// 4. let b = a.b
//struct A {
//    let value: Int
//    var b: B {
//        get { B(value: self.value) }
//        set { newValue.value }
//    }
//}
//
//struct B {
//    let value : Int
//}
//
//
//var a = A(value: 40)
//let b = a.b
//print(b)
//--------------------------------------
