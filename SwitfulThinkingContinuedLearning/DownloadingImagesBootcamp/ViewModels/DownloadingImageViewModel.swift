//
//  DownloadingImageViewModel.swift
//  SwitfulThinkingContinuedLearning
//
//  Created by Alexis Schotte on 10/30/21.
//

import Foundation
import SwiftUI
import Combine

class DownloadingImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
//    var manager = PhotoModelCacheManager.instance
    var manager = PhotoModelFileManager.instance
    
    var cancellables = Set<AnyCancellable>()
    
    let urlString: String
    let imageKey: String
    
    init(url: String, key: String) {
        urlString = url
        imageKey = key
        getImage()
    }
    
    func getImage() {
        
        if let imageCache = manager.get(key: imageKey) {
            image = imageCache
            print("Getting saved image")
        } else {
            print("Downloading image")
            downloadImage()
        }
    }
    
    func downloadImage() {
        isLoading = true
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
            
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data)}
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                guard
                    let self = self,
                    let image = returnedImage else { return }
                self.image = image
                self.manager.add(key: self.imageKey, value: image)
            }
            .store(in: &cancellables)

        
    }
    
}
