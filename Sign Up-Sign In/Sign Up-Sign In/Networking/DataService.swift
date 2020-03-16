//
//  DataService.swift
//  Sign Up-Sign In
//
//  Created by Admin on 16.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import Foundation

enum NetworkingErrors: String {
    case downloadError = "Error data downloading"
    case decodeError = "Error JSON decoding"
}


class DataService {
    
        let reference = "http://names.drycodes.com/10"
        
    func fetchData(completion: @escaping ([String]?) -> ()) {
            guard let url = URL(string: reference) else { return }
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("Fetching data: \(error!.localizedDescription)")
                }
                guard let data = data else {
                    print("Fetching data: " + NetworkingErrors.downloadError.rawValue)
                    return
                }
                do {
                    let recievedData = try JSONDecoder().decode([String]?.self, from: data)
                    print(recievedData)
                    completion(recievedData)
                } catch {
                    print("Fetching data: " + NetworkingErrors.decodeError.rawValue)
                }
            }.resume()
        }
        
    }
