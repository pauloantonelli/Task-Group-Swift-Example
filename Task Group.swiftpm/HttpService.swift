//
//  HttpService.swift
//  Task Group
//
//  Created by Paulo Antonelli on 25/10/22.
//

import Foundation
import UIKit

class HttpService {
    let dogBaseUrl: String = "https://dog.ceo/api/breeds/image/random"
    
    func fetchDog() async throws -> DogModel {
        let dogURL = URL(string: self.dogBaseUrl)!
        let (data, _) = try await URLSession.shared.data(from: dogURL)
        return try JSONDecoder().decode(DogModel.self, from: data)
    }
    
    func fetchDogImage() async throws -> UIImage {
        let dog = try await self.fetchDog()
        let (data, _) = try await URLSession.shared.data(from: dog.url)
        return UIImage(data: data)!
    }
    
    func fetchDogImageList() async throws -> Array<UIImage> {
        async let first = self.fetchDogImage()
        async let second = self.fetchDogImage()
        async let third = self.fetchDogImage()
        async let four = self.fetchDogImage()
        let result = try await [first, second, third, four]
        return result
    }
    
    func fetchFromMainThread() {
        DispatchQueue.main.async {
            // update UI
        }
    }
    
    func fetchFromOtherThread(qos: DispatchQoS.QoSClass = .userInteractive) {
        DispatchQueue.global(qos: qos).async {
            // fetch data from api
            DispatchQueue.main.async {
                // update UI
            }
        }
    }
    
    func fetchFromDispatchGroup() {
        let group = DispatchGroup()
        for _ in 0...100 {
            group.enter()
            let task = URLSession.shared.dataTask(with: URL(string: self.dogBaseUrl)!) { data, response, error in
                if error != nil {
                    print("Fetch Error")
                    return
                }
                defer {
                    group.leave()
                }
                guard let safeData = data else {
                    print("Fetch Error")
                    return
                }
                print(safeData)
            }
            task.resume()
        }
        group.notify(queue: .main) {
            // Update UI
        }
    }
}
