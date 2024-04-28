//
//  TaskView.swift
//  firebase
//
//  Created by Sattam Bandar Albogami on 19/10/1445 AH.
//

import SwiftUI

struct TaskView: View {
    @EnvironmentObject private var firebaseManager: FirebaseManager
    @State var isShowingAddItemView: Bool = false
    let category: Category

    var body: some View {
        NavigationStack {
            List {
                ForEach(firebaseManager.items, id: \.id) { item in
                    NavigationLink {
                        UpdateItemView(item: item, category: category)
                    } label: {
                        VStack {
                            Text(item.title)
                            Text(item.info)
                            Text(item.isDone.description)
                            Text(item.id)
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button {
                            Task {
                                try await firebaseManager.deleteItem(item, category)
                                try? await firebaseManager.fetchItems(category)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }.tint(.red)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingAddItemView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        Task {
                            try await firebaseManager.fetchItems(category)
                        }
                    } label: {
                        Text("Fetch from DB")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddItemView) {
                NavigationStack {
                    AddItemView(category: category)
                }
            }
            .onAppear {
                Task {
                    try await firebaseManager.fetchItems(category)
                }
            }
        }
    }
}


