//
//  FileManagerBootcamp.swift
//  SwitfulThinkingContinuedLearning
//
//  Created by Alexis Schotte on 10/27/21.
//

import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    let folderName = "My_App_Folder"
    
    init() {
        createFolder()
    }
    
    func createFolder() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path else {
                    print("Error on path")
                    return
                }
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error on creating directory: \(error.localizedDescription)")
            }
        }
        
    }
    
    func deleteFolder() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path else { return }
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Folder successfully removed")
        } catch let error {
            print("Error deleting folder: \(error.localizedDescription)")
        }
    }
    
    func saveImage(image: UIImage, name: String) {
        
        guard
            let data = image.jpegData(compressionQuality: 1.0),
            let path = getPath(name: name) else { return }

        do {
            try data.write(to: path)
            print(path)
            print("Success saving.")
        } catch let error {
            print("Error saving \(error.localizedDescription)")
        }
        
//        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let directory2 = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
//        let directory3 = FileManager.default.temporaryDirectory
    }
    
    func getImage(name: String) -> UIImage? {
        
        guard
            let path = getPath(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
                // something went wrong --> do something
                return nil
            }
        return UIImage(contentsOfFile: path)
        
    }
    
    func deleteImage(name: String) {
        guard
            let path = getPath(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
                print("Error on deleting")
                return
            }
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Successfully deleted.")
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
        
    }
    
    func getPath(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .appendingPathComponent("\(name).jpg") else {
            return nil
        }
        
        return path
    }
}

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let manager = LocalFileManager.instance
    let imageName = "image1"
    
    init() {
        getImageFromAssets()
//        getImageFromFileManager()
    }
    
    func getImageFromAssets() {
        image = UIImage(named: imageName)
    }
    
    func getImageFromFileManager() {
        image = manager.getImage(name: imageName)
    }
    
    func saveImage() {
        guard let image = image else { return }
        manager.saveImage(image: image, name: imageName)

    }
    
    func deleteImageFromFile() {
        manager.deleteImage(name: imageName)
        manager.deleteFolder()
    }
    
}

struct FileManagerBootcamp: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                HStack {
                    Button {
                        vm.deleteImageFromFile()
                    } label: {
                        Text("Delete Image")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.red.cornerRadius(10))
                            .lineLimit(1)
                    }
                    .padding()
                    Button {
                        vm.saveImage()
                    } label: {
                        Text("Save Image")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.blue.cornerRadius(10))
                            .lineLimit(1)
                    }
                    //.padding()
                }

                
                Spacer()
            }
            .navigationTitle("File Manager")
        }
    }
}

struct FileManagerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerBootcamp()
    }
}
