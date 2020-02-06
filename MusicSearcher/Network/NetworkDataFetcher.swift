//
//  NetworkDataFetcher.swift
//  MusicSearcher
//
//  Created by Станислав Жук on 06.02.2020.
//  Copyright © 2020 InsiderGroup. All rights reserved.
//

import Foundation

class NetworkDataFetcher {
    let networkService = LoadData()
    func fetchTracks(urlString: String, response: @escaping (SearchResult?) -> Void) {
        networkService.loadData(urlString: urlString) { (result) in
            switch result{
                
            case .success(let data):
                do{
                    let tracks = try JSONDecoder().decode(SearchResult.self, from: data)
                    response(tracks)
                }
                catch let jsonError {
                    print("Ошибка при обращении к JSON", jsonError)
                    response(nil)
                    
                }
                
            case .failure(let error):
                print("Запрашиваемые данные возвращают ошибку: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
}
