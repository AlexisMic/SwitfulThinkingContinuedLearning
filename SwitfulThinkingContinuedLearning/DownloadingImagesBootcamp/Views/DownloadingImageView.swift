//
//  DownloadingImageView.swift
//  SwitfulThinkingContinuedLearning
//
//  Created by Alexis Schotte on 10/30/21.
//

import SwiftUI

struct DownloadingImageView: View {
    
    @StateObject var loader: DownloadingImageViewModel
    
    init(url: String, key: String) {
        _loader = StateObject(wrappedValue: DownloadingImageViewModel(url: url, key: key))
    }
    
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else {
                if let image = loader.image {
                    Image(uiImage: image)
                        .resizable()
                        .clipShape(Circle())
                }
            }
        }
    }
}

struct DownloadingImageView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImageView(url: "https://via.placeholder.com/600/92c952", key: "1")
            .frame(width: 75, height: 75)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
