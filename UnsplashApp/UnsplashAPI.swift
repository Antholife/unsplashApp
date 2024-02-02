//
//  UnsplashAPI.swift
//  UnsplashApp
//
//  Created by Anthony Chahat on 02.02.2024.
//

import Foundation

struct UnsplashAPI {
    // Construit un objet URLComponents avec la base de l'API Unsplash
    // Et un query item "client_id" avec la clé d'API retrouvé depuis PListManager
    func unsplashApiBaseUrl(type: Int) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.unsplash.com"
        urlComponents.path = type == 0 ? "/photos" : "/topics"
        
        return urlComponents
    }
    
    // Par défaut orderBy = "popular" et perPage = 10 -> Lisez la documentation de l'API pour comprendre les paramètres, vous pouvez aussi en ajouter d'autres si vous le souhaitez
    func feedUrl(type: Int, orderBy: String = "popular", perPage: Int = 10) -> URL? {
        let id = ConfigurationManager.instance.plistDictionnary.clientId
        if let baseURL = unsplashApiBaseUrl(type: type).string {
            return type == 0 ? URL(string: "\(baseURL)?client_id=\(id)&order_by=\(orderBy)&per_page=\(perPage)") : URL(string: "\(baseURL)?client_id=\(id)&order_by=featured&per_page=\(perPage)")
        }
        return nil
    }
}
