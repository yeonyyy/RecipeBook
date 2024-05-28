//
//  RecipeRowView.swift
//  DietApp
//
//  Created by rayeon lee on 5/24/24.
//

import SwiftUI

struct RecipeRow: View {
    var categoryName: String
    var recipes: [Recipe]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 15)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(recipes) { recipe in
                        NavigationLink(value: recipe) {
                            RecipeItem(recipe:recipe)
                        }
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct RecipeRowView_Previews: PreviewProvider {
    static var previews: some View {
        let recipes = RecipeViewModel().recipes
        RecipeRow(
            categoryName: recipes[0].strCategory,
            recipes: Array(recipes.prefix(4))
        ).environmentObject(RecipeViewModel())
    }
}
