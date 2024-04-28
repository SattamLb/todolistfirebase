//
//  firebaseApp.swift
//  firebase
//
//  Created by Sattam Bandar Albogami on 14/10/1445 AH.
//

import SwiftUI
import FirebaseCore
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct ToDoFirebaseApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var firebaseManager = FirebaseManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(firebaseManager)
        }
    }
}
