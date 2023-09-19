//
//  ImageService.swift
//  LearnSwiftUI
//
//  Created by Rohit Sharma on 17/09/23.
//

import Foundation
import UIKit
import Combine
protocol ImageService {
    func fetchImage(url: String, completion: @escaping((UIImage) -> Void)) throws
}

class URLSessionImageService: ImageService {
    let session: URLSession
    var cancellables = Set<AnyCancellable>()
    init(session: URLSession = .shared){
        self.session = session
    }
    func fetchImage(url: String, completion: @escaping ((UIImage) -> Void))  {
        guard let url = URL(string: url) else {
            return
        }
        session.dataTask(with: url) { data, response, error in
            if let data = data, let imageData = UIImage(data: data) {
                completion(imageData)
            }
        }.resume()
    }
    //https://images.dog.ceo/breeds/bulldog-french/n02108915_7115.jpg
    
}
