//
//  RecipeItemView.swift
//  DietApp
//
//  Created by rayeon lee on 5/25/24.
//

import SwiftUI

struct RecipeItem: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    var recipe : Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            viewModel.thumbImage[recipe].map { image in
                Image(uiImage: image)
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
            }
            Text(recipe.strMeal)
                .foregroundStyle(.primary)
                .font(.caption)
                .frame(width: 100, alignment: .leading)
                .lineLimit(1)
        }
        .padding(.leading, 15)
        .task {
            viewModel.loadThumbImage(for: recipe)
        }
    }
}

struct RecipeItemView_Previews: PreviewProvider {
    static var previews: some View {
        let recipes = RecipeViewModel().recipes
        RecipeItem(recipe: recipes[0]).environmentObject(RecipeViewModel())
    }
}
