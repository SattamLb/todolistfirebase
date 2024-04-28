//
//  ubdateItem.swift
//  firebase
//
//  Created by Sattam Bandar Albogami on 16/10/1445 AH.
//

import SwiftUI

struct UpdateItemView: View {
    @EnvironmentObject private var firebaseManager: FirebaseManager
    @Environment(\.dismiss) private var dismiss
    @State var title: String = ""
    @State var info: String = ""
    @State var dueDate: Date = .now
    @State var timestamp: Date = .now
    @State var isDone: Bool = false
    var item: Item
    var category: Category
    var body: some View {
        Form{
            Section{
                TextField("title", text: $title)
                TextField("title", text: $info)
                DatePicker(selection: $dueDate) {
                    Text("Due Date")
                }
                Toggle(isOn: $isDone) {
                    Text("Is Done")
                }
            }
            
            Button(action: {
                // let item
                let item = Item(id: item.id,
                                title: title,
                                info: info,
                                dueDate: dueDate)
                Task {
                    firebaseManager.updateItem(item , category)
                    dismiss()
                }
            }, label: {
                Text("Update Item")
            }).frame(maxWidth: .infinity, alignment: .center)
                .font(.title3)
                .buttonStyle(.borderless)
                .foregroundStyle(.white)
                .listRowBackground(Color.blue)
        }
        .navigationTitle("Update Item")
        .onAppear{
            title = item.title
            info = item.info
            isDone = item.isDone
            dueDate = item.dueDate
        }
    }
}

#Preview {
    UpdateItemView(item: .init(id: "", title: "",
                               info: "", dueDate: .now), category: Category(id: "", name: ""))
        .environmentObject(FirebaseManager())
}

