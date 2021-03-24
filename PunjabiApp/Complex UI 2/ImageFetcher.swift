//
//  ImageFetcher.swift
//  Complex UI 2
//
//  Created by Bharat Kumar on 8/24/20.
//  Copyright © 2020 Balaji. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class ImageFetcher {
    var didChange = PassthroughSubject<Data, Never>()
    
    var data: Data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    init(url: String) {
        guard let imageUrl = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { (data, _, _) in
            guard let data = data else { return }
            DispatchQueue.main.async { [weak self] in
                self?.data = data
            }
            
        }.resume()
    }
}
