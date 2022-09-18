//
//  CacheBootcamp.swift
//  SwitfulThinkingContinuedLearning
//
//  Created by Alexis Schotte on 10/29/21.
//

import SwiftUI

struct CacheManager {
    
    // Singleton
    static let instance = CacheManager()
    private init() {}
    
    let cacheImage: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    func save(name: String, image: UIImage) {
        cacheImage.setObject(image, forKey: name as NSString)
        print("Successfully saved!")
    }
    
    func delete(name: String) {
        cacheImage.removeObject(forKey: name as NSString)
    }
    
    func get(name: String) -> UIImage? {
        return cacheImage.object(forKey: name as NSString)
    }
    
}

class CacheViewModel: ObservableObject {
    
    let manager = CacheManager.instance
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    let imageName = "image1"
    
    init() {
        getImageFromAssets()
//        getFromCache()
    }
    
    func getImageFromAssets() {
        startingImage = UIImage(named: imageName)
    }
    
    func getFromCache() {
        cachedImage = manager.get(name: imageName)
    }
    
    func saveToCache () {
        guard let image = startingImage else {
            print("Error saving image")
            return
        }
        manager.save(name: imageName, image: image)
    }
    
    func deleteFromCache() {
        manager.delete(name: imageName)
    }
    
}

struct CacheBootcamp: View {
    
    @StateObject var vm = CacheViewModel()
    
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                HStack {
                    Button {
                        vm.saveToCache()
                        
                    } label: {
                        Text("Save to Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue.cornerRadius(10))
                            .padding()
                    }
                    Button {
                        vm.deleteFromCache()
                    } label: {
                        Text("Delete from Cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red.cornerRadius(10))
                            .padding(.vertical)
                            .lineLimit(1)
                    }
                    
                }
                Button {
                    vm.getFromCache()
                } label: {
                    Text("Get from Cache")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green.cornerRadius(10))
                        .padding(.vertical)
                        .lineLimit(1)
                }
                if let image = vm.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }

                
                Spacer()
            }
            .navigationTitle("Cache")
        }
    }
}

struct CacheBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CacheBootcamp()
    }
}
