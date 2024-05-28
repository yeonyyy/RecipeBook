//
//  RecipeDetailView.swift
//  DietApp
//
//  Created by rayeon lee on 5/23/24.
//

import SwiftUI

struct RecipeDetail: View {
    var recipe : Recipe
    
    var body: some View {
        ScrollView {
            VStack {
                RecipeImage(loader: ImageLoadingViewModel(urlString: recipe.strMealThumb))
                    .aspectRatio(contentMode: .fill)
                .background(.blue)
            }
            
            VStack(alignment: .leading) {
                Text(recipe.strMeal)
                    .font(.title)
                Divider()
                Text(recipe.strInstructions)
            }
            .padding()
            
            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let recipes = RecipeViewModel().recipes
        RecipeDetail(recipe: recipes[0])
    }
}

