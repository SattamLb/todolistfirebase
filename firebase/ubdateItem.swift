//
//  ubdateItem.swift
//  firebase
//
//  Created by Sattam Bandar Albogami on 16/10/1445 AH.
//

import SwiftUI

struct ubdateItem: View {
    @EnvironmentObject private var firebaseManager: firebaseManager
    @Environment(\.dismiss) private var dismiss
    @State var title: String = ""
    @State var info: String = ""
    @State var dueDate: Date = .now
    @State var timestamp: Date = .now
    @State var isDone : Bool = false
    var item : Item
    var body: some View {
        Form{
            Section{
                TextField("title", text: $title)
                TextField("title", text: $info)
                DatePicker(selection: $dueDate) {
                    Text("Due Date")
                }
                Toggle(isOn: $isDone){
                    Text("is Done")
                }
            }
            
            Button(action: {
                // let item
                let item = Item(id:UUID().uuidString,
                                title: title,
                                info: info,
                                dueDate: dueDate)
                Task {
                    try await firebaseManager.createItem(item)
//                  ✅  try await firebaseManager.fetchItems()
                    dismiss()
//                  ✅  try await firebaseManager.fetchItems()
                }
            }, label: {
                Text("Add Item")
            }).frame(maxWidth: .infinity, alignment: .center)
                .font(.title3)
                .buttonStyle(.borderless)
                .foregroundStyle(.white)
                .listRowBackground(Color.blue)
        }
        .navigationTitle("upd
                         ate New Item")
        .onAppear{
            title = item.title
            info = item.info
            isDone = item.isDone
            dueDate = item.dueDate
        }
    }
}

#Preview {
    ubdateItem(item: .init( id: "", title: "", info: "", dueDate: .now) )
        .environmentObject(firebaseManager())
}
