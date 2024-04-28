//
//  AddCategory.swift
//  firebase
//
//  Created by Sattam Bandar Albogami on 19/10/1445 AH.
//

import SwiftUI

struct AddCategory: View {
    @State private var categoryTitle = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var firebaseManager: FirebaseManager
    
    var body: some View {
        NavigationStack {
            VStack{
                TextField("Category" , text: $categoryTitle)
            }
            .padding()
            Section() {
                Button("Add Category") {
                    let cat = Category(id: UUID().uuidString, name: categoryTitle)
                    Task {
                        try await firebaseManager.createCategory(cat)
                        try? await firebaseManager.fetchCategories()
                    }
                    dismiss()
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            .navigationTitle("Add Category")
            
        }
    }
}

#Preview {
    AddCategory()
        .environmentObject(FirebaseManager())
}

