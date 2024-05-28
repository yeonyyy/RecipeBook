//
//  ImageLoadingViewModel.swift
//  DietApp
//
//  Created by rayeon lee on 5/28/24.
//

import UIKit
import SwiftUI
import Combine

private let imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoadingViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = true
    
    private var cancellables = Set<AnyCancellable>()
    
    let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
        getImage()
    }
    
    func getImage() {
        let urlString = urlString
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }else {
            downloadImage()
        }
    }
    
    func downloadImage() {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.send(request: request)
            .map { UIImage(data: $0) }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] _ in
                guard let self = self else { return }
                
                self.isLoading = false
            }, receiveValue: { [weak self] image in
                guard let self = self else { return }
                guard let image = image else { return }
                self.image = image
                
                let urlString = self.urlString
                imageCache.setObject(image, forKey: urlString as AnyObject)
            })
            .store(in: &cancellables)
    }
}
