//
//  RecipeView.swift
//  DietApp
//
//  Created by rayeon lee on 5/23/24.
//

import SwiftUI

struct RecipeHome: View {
    @EnvironmentObject var modelData : RecipeViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    RecipeRow(categoryName: key, recipes: modelData.categories[key]!)
                }
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle("Recipe")
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetail(recipe: recipe)
            }
        }
    }
}

struct RecipeHomeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeHome().environmentObject(RecipeViewModel())
    }
}
