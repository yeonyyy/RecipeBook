//
//  RecipeBookApp.swift
//  RecipeBook
//
//  Created by rayeon lee on 5/28/24.
//

import SwiftUI

@main
struct RecipeBookApp: App {
    @StateObject private var modelData = RecipeViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(modelData)
        }
    }
}
