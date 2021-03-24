//
//  LoadableImage.swift
//  Complex UI 2
//
//  Created by Bharat Kumar on 8/24/20.
//  Copyright © 2020 Balaji. All rights reserved.
//

import SwiftUI


struct LoadableImageView: View {
    var imageFetcher: ImageFetcher
    
    var stateContent: AnyView {
        if let image = UIImage(data: imageFetcher.data) {
            return AnyView(
                Image(uiImage: image).resizable()
            )
        } else {
            return AnyView(
                ActivityIndicator(style: .medium)
            )
        }
    }
    
    init(with urlString: String) {
        imageFetcher = ImageFetcher(url: urlString)
    }
    
    var body: some View {
        HStack {
            stateContent
        }
    }
}
#if DEBUG
struct LoadableImageView_Previews : PreviewProvider {
    static var previews: some View {
        LoadableImageView(with: FBUser.currentUser.pictureURL!)
    }
}
#endif

struct ActivityIndicator: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}
