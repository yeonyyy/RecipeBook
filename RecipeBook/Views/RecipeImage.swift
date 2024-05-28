//
//  RecipeImageView.swift
//  DietApp
//
//  Created by rayeon lee on 5/28/24.
//

import SwiftUI

struct RecipeImage: View {
    @StateObject var loader: ImageLoadingViewModel
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(height: 300)
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
            }
        }
    }
}

struct RecipeImageView_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = RecipeViewModel().recipes
        RecipeImage(loader: ImageLoadingViewModel(urlString: recipe[0].strMealThumb))
    }
}
