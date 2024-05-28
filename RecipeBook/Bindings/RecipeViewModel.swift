//
//  ModelData.swift
//  DietApp
//
//  Created by rayeon lee on 5/24/24.
//

import SwiftUI
import Combine

final class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = load("recipesJson.json")
    @Published private(set) var thumbImage = [Recipe: UIImage]()
    
    private var cancellables = Set<AnyCancellable>()
    
    var categories: [String: [Recipe]] {
        Dictionary(
            grouping: recipes,
            by: { $0.strCategory }
        )
    }
    
    func loadThumbImage(for recipe: Recipe) {
        guard case .none = thumbImage[recipe] else { return }
        
        let urlStr = recipe.strMealThumb + "/preview"
        let url = URL(string: urlStr)!
        let request = URLRequest(url: url)
        
        URLSession.shared.send(request: request)
            .map { UIImage(data: $0) }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] image in
                self?.thumbImage[recipe] = image
            })
            .store(in: &cancellables)
        
    }
    
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

