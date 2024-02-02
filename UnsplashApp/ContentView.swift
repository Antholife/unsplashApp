//
//  ContentView.swift
//  UnsplashApp
//
//  Created by Anthony Chahat on 02.02.2024.
//

import SwiftUI

struct ContentView: View {

        @StateObject var feedState = FeedState()

        let columns = [GridItem(.flexible()), GridItem(.flexible())]

        var body: some View {
            VStack {
                NavigationStack {
                    // le bouton va lancer l'appel réseau
                    Button(action: {
                        Task {
                            await feedState.fetchFeed(type: 1)
                            await feedState.fetchFeed(type: 0)
                        }
                    }, label: {
                        Text("Load...")
                    })
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        if let data = feedState.topicsListFeed {
                            LazyHGrid(rows: [GridItem(.flexible())], content: {
                                ForEach(data){ img in
                                    VStack {
                                        AsyncImage(url: URL(string: img.cover_photo.urls.regular)) { img in
                                            img.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }.frame(width: 150, height: 120).cornerRadius(12)
                                        Text(img.title).frame(width: 150, height: 10)
                                    }
                                }
                            })
                        }
                        else {
                            LazyHGrid(rows: [GridItem(.flexible())], content: {
                                ForEach(0...5, id: \.self){_ in
                                    VStack {
                                        RoundedRectangle(cornerRadius: 12).frame(width: 150, height: 120).cornerRadius(12).foregroundStyle(.placeholder)
                                        RoundedRectangle(cornerRadius: 12).frame(width: 150, height: 10).cornerRadius(12).foregroundStyle(.placeholder)
                                    }
                                }
                            })
                        }
                    }).frame(height: 160)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    ScrollView(showsIndicators: false) {
                        if let data = feedState.homeFeed {
                            LazyVGrid(columns: columns, content: {
                                ForEach(data){ img in
                                    AsyncImage(url: URL(string: img.urls.regular)) { img in
                                        img.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }.frame(width: .infinity, height: 150).cornerRadius(12)
                                }
                            })
                        }
                        else {
                            LazyVGrid(columns: columns, content: {
                                ForEach(0...13, id: \.self){_ in
                                    RoundedRectangle(cornerRadius: 12).frame(width: .infinity, height: 150).cornerRadius(12).foregroundStyle(.placeholder)
                                }
                            })
                        }
                    }.clipShape(Rectangle())
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        .navigationTitle("Feed")
                }
            }
        }
}

#Preview {
    ContentView()
}
