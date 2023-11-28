//
//  NavigationTest2.swift
//  CombineTest
//
//  Created by sako0602 on 2023/11/20.
//

import SwiftUI


struct Member: Identifiable, Codable {
    var id = UUID()
    let name: String
}

struct WarikanGroup: Identifiable, Codable {
    var id = UUID()
    let name: String
    let members: [Member]
}


struct TransactionRecord: Identifiable, Codable {
    var id = UUID()
    let fromMember: Member
    let toMembers: [Member]
    let money: Int
}

class UserDefaultsRepository<T: Identifiable & Codable> {
    private let userDefaultsKey: String
//    @Published private(set) var items: [T]
    private(set) var items: [T]
    
    init(userDefaultsKey: String) {
        self.userDefaultsKey = userDefaultsKey
        
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let items = try? JSONDecoder().decode([T].self, from: data) // FIXME: try?
        else {
            self.items = []; return;
        }
        
        self.items = items
    }
    
    func getItems() -> [T] {
        return items
    }
    
    func addItem(_ item: T) {
        items.append(item)
        update()
    }
    
    func removeItem(at indices: [Int]) {
        indices.sorted().reversed().forEach { index in
            items.remove(at: index)
        }
        update()
    }
    
    func removeAllOfItems() {
        items.removeAll()
        update()
    }
    
    private func update() {
        guard let encodedData = try? JSONEncoder().encode(items) else { return }
        UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
    }
}



struct MemberUsecase {
    private(set) var repository: UserDefaultsRepository<Member>
    
    init(repository: UserDefaultsRepository<Member>) {
        self.repository = repository
    }
    
    func getAllMembers() -> [Member] {
        return repository.getItems()
    }
    
    func add(name: String) {
        repository.addItem(Member(name: name))
    }
    
    func remove(at indices: [Int]) {
        repository.removeItem(at: indices)
    }
}


class ContentViewModel: ObservableObject {
//    private let transactionStore = UserDefaultsRepository<TransactionRecord>(userDefaultsKey: "transactionRecord")
//    private let warikanGroups = UserDefaultsRepository<WarikanGroup>(userDefaultsKey: "warikanGroup")
//    private let memberRepository = UserDefaultsRepository<Member>(userDefaultsKey: "members")
    private let memberUsecase = MemberUsecase(
        repository: UserDefaultsRepository<Member>(userDefaultsKey: "members")
    )
    @Published private(set) var members: [Member] = []
    
    init() {
        members = memberUsecase.getAllMembers()
    }
    
    func addMember(name: String) {
        memberUsecase.add(name: name)
        members = memberUsecase.getAllMembers()
    }
    
    func removeMember(at indexSet: IndexSet) {
        memberUsecase.remove(at: Array(indexSet))
        members = memberUsecase.getAllMembers()
    }
}



struct ContentView2: View {
    @StateObject var vm = ContentViewModel()
    
    var body: some View {
        List {
            ForEach(vm.members) { member in
                Text(member.name)
            }
            .onDelete { indexSet in
                vm.removeMember(at: indexSet)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button("Add") {
                    vm.addMember(name: Int.random(in: 1000...9999).description)
                }
            }
        }
    }
}
#Preview {
    ContentView2()
}
