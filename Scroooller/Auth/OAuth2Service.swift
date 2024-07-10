//
//  OAuth2Service.swift
//  Scroooller
//
//  Created by Виктория Демченко on 01.07.24.
//

import UIKit

final class OAuth2Service {
    static let shared = OAuth2Service()
    private init() {}
    
    func makeOAuthTokenRequest(code: String) -> URLRequest? {
        let baseURL = URL(string: "https://unsplash.com")
        
        guard let baseURL = baseURL else {
            print("Error")
            return nil
        }
        
        guard let url = URL(
            string: "/oauth/token"
            + "?client_id=\(Constants.accessKey)"
            + "&&client_secret=\(Constants.secretKey)"
            + "&&redirect_uri=\(Constants.redirectURI)"
            + "&&code=\(code)"
            + "&&grant_type=authorization_code",
            relativeTo: baseURL
        )else {
            print("Неверный URL для запроса")
            return nil
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        return request
    }
    
    func fetchOAuthToken(code: String, handler: @escaping (Result<String, Error>) -> Void){
        // Получаем URLRequest
        guard let request = makeOAuthTokenRequest(code: code) else {
            print("Ошибка при создании запроса")
            return
        }
        
        // Создаем задачу dataTask
        let task = URLSession.shared.data(for: request){result in
            let decoder = JSONDecoder()
            switch result {
            case .success(let data):
                do {
                    let response = try decoder.decode(OAuthTokenResponseBody.self, from: data)
                    // Обработка успешного декодирования
                    print("Decoded response: \(response)")
                    OAuth2TokenStorage.shared.token = response.access_token
                    handler(.success(response.access_token))
                } catch {
                    // Обработка ошибки декодирования
                    handler(.failure("Failed to decode JSON: \(error)" as! Error))
                }
            case .failure(let error):
                // Обработка ошибки
                handler(.failure("Request failed with error: \(error)" as! Error))
            }
        }
        
        // Запуск задачи
        task.resume()
    }
}
