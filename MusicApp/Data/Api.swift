//
//  Api.swift
//  MusicApp
//
//  Created by FELIPE AUGUSTO SILVA on 09/02/22.
//

import Foundation

// MARK: CREATE PROTOCOL
protocol MusicApiProtocol {
    func getMusic(Artist: String, completion: @escaping ([Artist]) -> ())
}

// MARK: Fetch API
class ItunesApi: MusicApiProtocol {
    let baseURL = "https://itunes.apple.com/"
    func getMusic(Artist: String, completion: @escaping ([Artist]) -> ()) {
        guard let sourceURL = URL(string: "\(baseURL)search?media=music&entity=song&term=\(Artist)") else {
            return
        }
        URLSession.shared.dataTask(with: sourceURL) { (data, URLResponse, error) in
            if let data = data {
            let jsonDecoder = JSONDecoder()
            let results = try! jsonDecoder.decode(Music.self, from: data)
                completion(results.results)
                print(results.results)
        }
        }.resume()
    }
    
    
}
