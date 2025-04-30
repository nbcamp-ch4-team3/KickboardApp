//
//  NetworkService.swift
//  KickboardApp
//
//  Created by 이수현 on 4/30/25.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchLocalInfo(query: String) async throws -> LocalDTO
}

final class NetworkService: NetworkServiceProtocol {
    private let baseURL = "https://openapi.naver.com"

    func fetchLocalInfo(query: String) async throws -> LocalDTO {
        let path = "/v1/search/local.json"
        guard var components = URLComponents(string: baseURL + path) else {
            throw NetworkError.invalidURL(url: baseURL + path)
        }
        components.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "display", value: "5"),
            URLQueryItem(name: "start", value: "1"),
            URLQueryItem(name: "sort", value: "random")
        ]

        guard let url = components.url else {
            throw NetworkError.invalidURL(url: baseURL)
        }

        var request = URLRequest(url: url)

        //TODO: 헤더 추가
        if let secret = Bundle.main.infoDictionary?["SearchClientSecret"] as? String,
           let clientId = Bundle.main.infoDictionary?["SearchClientId"] as? String {
            request.addValue(clientId, forHTTPHeaderField: "X-Naver-Client-Id")
            request.addValue(secret, forHTTPHeaderField: "X-Naver-Client-Secret")
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            // reponse 확인
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }

            // 상태 코드 확인
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.serverError(statusCode: httpResponse.statusCode)
            }

            do {
                // 디코딩
                return try JSONDecoder().decode(LocalDTO.self, from: data)
            } catch {
                // 디코딩 실패
                throw NetworkError.decodingError(error: error)
            }
        } catch {
            if let networkError = error as? NetworkError {
                throw networkError
            }

            throw NetworkError.networkFailure(error: error)
        }
    }
}
