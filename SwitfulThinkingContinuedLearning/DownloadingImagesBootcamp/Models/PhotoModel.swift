//
//  PhotoModel.swift
//  SwitfulThinkingContinuedLearning
//
//  Created by Alexis Schotte on 10/30/21.
//

import Foundation

struct PhotoModel: Identifiable, Codable {
    let id: Int
    let albumId: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
    
}
