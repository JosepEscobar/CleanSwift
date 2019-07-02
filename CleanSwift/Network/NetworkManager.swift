//
//  NetworkManager.swift
//  CleanSwift
//
//  Created by Josep Escobar on 01/07/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import Foundation

class NetworkManager {
    func getUsers(completionHandler: @escaping ([User]) -> Void ) {

        // TODO : Remove hardcoded values
        let params = [NetworkEndpointParameter.page: "1",
                      NetworkEndpointParameter.results: "10"]

        let url = URL(string: "\(NetworkEndpoint.baseURL)?\(params.queryString)")!

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let arrayUsers = [User]()
            DispatchQueue.main.async {
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodedResponse = try decoder.decode(UserResponse.self, from: data)
                        completionHandler(decodedResponse.results)
                    } catch let error as NSError {
                        print(error.localizedDescription)
                        completionHandler(arrayUsers)
                    }
                }
            }
        }.resume()
    }
}
