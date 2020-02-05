//
//  LoadData.swift
//  MusicSearcher
//
//  Created by Станислав Жук on 05.02.2020.
//  Copyright © 2020 InsiderGroup. All rights reserved.
//

import Foundation

func loadData(urlString: String, completion: @escaping (Result<SearchResult, Error>)->Void){

guard let url = URL(string: urlString) else { return }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        DispatchQueue.main.async {
            if let error = error {
                print("ошибка полученных данных")
                completion(.failure(error))
                return
            }
            guard let data = data else {return}
            do{
                let tracks = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(.success(tracks))
            }
            catch let jsonError {print("Ошибка при обращении к JSON", jsonError)
                completion(.failure(jsonError))
            }
            
        }
    }.resume()
}
