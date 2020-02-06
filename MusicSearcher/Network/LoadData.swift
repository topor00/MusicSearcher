//
//  LoadData.swift
//  MusicSearcher
//
//  Created by Станислав Жук on 05.02.2020.
//  Copyright © 2020 InsiderGroup. All rights reserved.
//

import Foundation

class LoadData {
    func loadData(urlString: String, completion: @escaping (Result<Data, Error>)->Void){

    guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {return}
                completion(.success(data))
            }
        }.resume()
    }

}
