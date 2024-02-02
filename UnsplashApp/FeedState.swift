//
//  FeedState.swift
//  UnsplashApp
//
//  Created by Anthony Chahat on 02.02.2024.
//

import Foundation

struct UnsplashPhoto: Codable, Identifiable {
    let id: String
    let slug: String
    var user: User
    let urls: UnsplashPhotoUrls
}

struct User: Codable {
    let name: String
}

struct UnsplashPhotoUrls: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
    let small_s3: String
}

struct UrlTopics: Codable {
    let urls: UnsplashPhotoUrls
}

struct Topics: Codable, Identifiable {
    let id: String
    let title: String
    let cover_photo: UrlTopics
}

class FeedState: ObservableObject {
    
    @Published var homeFeed: [UnsplashPhoto]?
    @Published var topicsListFeed: [Topics]?
    
    // Fetch home feed doit utiliser la fonction feedUrl de UnsplashAPI
    // Puis assigner le résultat de l'appel réseau à la variable homeFeed
    
    var API: UnsplashAPI = UnsplashAPI()
    
    func fetchFeed(type: Int) async {
        if (type == 0){
            if let url = API.feedUrl(type: type) {
                do {
                    
                    let request = URLRequest(url: url)
                    
                    // Faites l'appel réseau
                    let (data, _) = try await URLSession.shared.data(for: request)
                    
                    // Transformez les données en JSON
                    let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
                    
                    // Mettez à jour l'état de la vue
                    homeFeed = deserializedData
                    
                } catch {
                    print("Error: \(error)")
                }
            }
        } else {
            if let url = API.feedUrl(type: type) {
                do {
                    print(url)
                    let request = URLRequest(url: url)
                    
                    // Faites l'appel réseau
                    let (data, _) = try await URLSession.shared.data(for: request)
                    
                    // Transformez les données en JSON
                    let deserializedData = try JSONDecoder().decode([Topics].self, from: data)
                    
                    // Mettez à jour l'état de la vue
                    topicsListFeed = deserializedData
                    
                } catch {
                    print("Error: \(error)")
                }
            }
        }
    }
}
    
