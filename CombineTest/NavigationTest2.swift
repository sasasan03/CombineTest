//
//  NavigationTest2.swift
//  CombineTest
//
//  Created by sako0602 on 2023/11/20.
//

import SwiftUI

struct Book: Hashable{
//    let page: String
    let title: String
}

struct NavigationTest2: View {
    
    @State private var books:[Book] = []
    @State private var title = ""
    
    var body: some View {
        NavigationStack{
            VStack{
//                TextField("入力", text: $title)
                NavigationLink {
                    View1(books: Book(title: "桃太郎"))
                } label: {
                    Image(systemName: "circle")
                }
//                Button("遷移"){
//                    pageAdd()
//                }
            }
//            .navigationDestination(for: Book.self, destination: { book in
//                View1(books: book)
//            })
        }
    }
    func pageAdd(){
        books.append(Book(title: title))
    }
}


struct View1: View {
    
    let books: Book
    
    var body: some View {
        VStack{
            Text(books.title)
//            Text(books.page)
        }
    }
}


#Preview {
    NavigationTest2()
}
