//
//  PhotoModelFileManager.swift
//  SwitfulThinkingContinuedLearning
//
//  Created by Alexis Schotte on 10/31/21.
//

import Foundation
import SwiftUI

class PhotoModelFileManager {
    
    static let instance = PhotoModelFileManager()
    let folderName = "downloaded_images"
    
    private init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard let url = getFolderPath() else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                print("Created folder")
            } catch let error {
                print("Error creating folder \(error.localizedDescription)")
            }
        }
    }
    
    func getFolderPath() -> URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }
    
    func getImagePath(key: String) -> URL? {
        guard let folderPath = getFolderPath() else { return nil}
        return folderPath
            .appendingPathComponent(key + ".png")
    }
    
    func add(key: String, value: UIImage) {
        guard
            let data = value.pngData(),
            let url = getImagePath(key: key) else {
                print("Error adding image")
                return
            }
        do {
            try data.write(to: url)
            print("Successfully saved")
        } catch let error {
            print("Error saving image \(error.localizedDescription)")
        }
    }
    
    func get(key: String) -> UIImage? {
        guard
            let url = getImagePath(key: key),
            FileManager.default.fileExists(atPath: url.path) else {
                print("Error getting image")
                return nil
            }
        return UIImage(contentsOfFile: url.path)
    }
}
