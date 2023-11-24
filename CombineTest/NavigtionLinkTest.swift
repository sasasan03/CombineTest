//
//  NavigtionLinkTest.swift
//  CombineTest
//
//  Created by sako0602 on 2023/11/18.
//

import SwiftUI

struct Restaurant:Identifiable,Hashable {
    let id = UUID()
    let name: String
}

struct Park: Identifiable, Hashable {
    let id = UUID()
    let name: String
}

struct RestaurantView: View {
    
    let restaurant: Restaurant
    
    var body: some View {
        Text(restaurant.name)
    }
}

struct ParkDetail: View {
    
    let park: Park
    
    var body: some View {
        Text(park.name)
    }
}


struct NavigtionLinkTest: View {
    
    @State private var colors: [Color] = [.red,.green,.yellow,.brown]
//    @State private var selection: Color?
//    @State private var parks = [Park(name: "大阪城公園"),Park(name: "小屋ダム公園")]
//    @State private var restaurants = [Restaurant(name: "与一"),Restaurant(name: "見附")]
    @State private var navigationPath = NavigationPath()
    
    
    
    
    var body: some View { //⭐️NavigationLinkのサンプルコード
        
        NavigationStack{//(path: $colors){
            List{
//                NavigationLink("黒"){ ColorDetail(color: .black)}
//                NavigationLink("ピンク"){ ColorDetail(color: .pink)}
//                NavigationLink("オレンジ"){ ColorDetail(color: .orange)}
//                NavigationLink {
//                    FolderDtail(id: 123)
//                } label: {
//                    Label("List？", systemImage: "square.and.arrow.down.fill")
//                }
//                NavigationLink("青"){
//                    Color.blue
//                }
                Button("紫を追加"){
                    showPurple()
                }
            }
            .navigationDestination(for: Color.self, destination: { color in
                ColorDetail(color: color)
            })
            .navigationTitle("色")
        }
    }
    func showPurple(){
        colors.append(.purple)
    }
    
    
    
    
    
    
    
    
//    var body: some View {
//        NavigationStack(path: $navigationPath) {
//            List{
//                ForEach(parks){ park in
//                    NavigationLink(park.name, value: park)
//                }
//                
//                Section{
//                    ForEach(restaurants){ restaurant in
//                        NavigationLink(restaurant.name, value: restaurant)
//                    }
//                }
//            }
//            .navigationDestination(for: Park.self) { park in
//                ParkDetail(park: park)
//            }
//            .navigationDestination(for: Restaurant.self){ restaurant in
//                RestaurantView(restaurant: restaurant)
//            }
//            Button("aaa"){
//                
//                
//            }
//        }
//    }

    
    
    
    
    
//    var body: some View {//⭐️SplitViewTest
//        NavigationSplitView {
//            List(colors, id: \.self ,selection: $selection) { color in
//                NavigationLink(color.description, value: color)
//            }
//        } detail: {
//            if let color = selection {
//                ColorDetail(color: color)
//            } else {
//                Text("Pick a color")
//            }
//        }
    
    
    
    
    
    

    
    
    
    
    
    
    
    
}

struct ColorDetail: View {
    
    var color: Color
    
    var body: some View {
        color.navigationTitle(color.description)
    }
}

struct FolderDtail: View {
    
    let id:Int
    
    var body: some View{
        Text("\(id)")
    }
}

#Preview {
    NavigtionLinkTest()
}
