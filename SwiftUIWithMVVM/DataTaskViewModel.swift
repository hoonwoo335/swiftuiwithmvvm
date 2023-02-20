//
//  DataTaskViewModel.swift
//  SwiftUIWithMVVM
//
//  Created by Jerry Uhm on 2023/02/20.
//

import Foundation
import Combine

// Model
struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

// ViewModel with ObservableObject
class DataTaskViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    
    var disposeBag = Set<AnyCancellable>()
    
    init() {
        
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .sink(receiveValue: { [weak self] receivePosts in
                self?.posts = receivePosts
            })
            .store(in: &disposeBag)
    }
}
