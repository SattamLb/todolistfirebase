//
//  updateCategory.swift
//  firebase
//
//  Created by Sattam Bandar Albogami on 19/10/1445 AH.
//
//llkoodklkvodvldslkv
import SwiftUI
import Swift
struct updateCategory: View {
    @State private var categoryTitle = ""
    var category: Category
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var firebaseManager: FirebaseManager
    
    var body: some View {
        NavigationStack {
            VStack{
                TextField("Category" , text: $categoryTitle)
            }
            
            Section() {
                Button("Update Category") {
                    let cat = Category(id: category.id, name: categoryTitle)
                    Task {
                        firebaseManager.updateCategory(cat)
                        try? await firebaseManager.fetchCategories()
                    }
                    dismiss()
                    
                }
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Update Category")
            .onAppear {
                categoryTitle = category.name
                
            }
        }
    }
}

#Preview {
    updateCategory(category: Category(id: "", name: ""))
}

