//
//  SportManager.swift
//  Sport App
//
//  Created by Екатерина Орлова on 20.03.2025.
//

import Foundation

struct SportManager {
    private let apiKey = "YM6sTKqXUZvbwMtS5jCJhA==v7KJDg6AnKaUcH8P"
    private let baseURL = "https://api.api-ninjas.com/v1/exercises"
    
    func fetchData(completionHandler:@escaping (_ response: [SportMainModel])->Void ) {
        
        let url = URL(string: baseURL)!
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
            do {
                let result = try JSONDecoder().decode([SportMainModel].self, from: data)
                print(result)
                completionHandler(result)
            } catch {
                print("Failed to convert JSON\(error)")
            }
        }
        task.resume()
    }
}
