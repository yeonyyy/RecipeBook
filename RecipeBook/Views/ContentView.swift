//
//  ContentView.swift
//  DietApp
//
//  Created by rayeon lee on 5/23/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        RecipeHome()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(RecipeViewModel())
    }
}
