//
//  NetworkManager.swift
//  Personal Trainer
//
//  Created by Andrew Acheampong on 5/28/25.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case badResponse(statusCode: Int)
    case decodingError
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid server URL."
        case .badResponse(let code):
            return "Server returned status code \(code)."
        case .decodingError:
            return "Failed to decode response."
        case .unknown(let err):
            return err.localizedDescription
        }
    }
}



final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    // Change this to your actual endpoint
    private let baseURL = "https://api.yourdomain.com"

    /// Sends the UserInput JSON and returns a CoachResult
    func fetchPlan(input: UserInput) async throws -> CoachResult {
        // 1. Construct URL
        guard let url = URL(string: "\(baseURL)/fitness-plan") else {
            throw NetworkError.invalidURL
        }

        // 2. Build request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // 3. Encode body
        do {
            request.httpBody = try JSONEncoder().encode(input)
        } catch {
            throw NetworkError.unknown(error)
        }

        // 4. Send & receive
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            throw NetworkError.unknown(error)
        }

        // 5. Validate status code
        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.badResponse(statusCode: -1)
        }
        guard (200..<300).contains(http.statusCode) else {
            throw NetworkError.badResponse(statusCode: http.statusCode)
        }

        // 6. Decode JSON
        do {
            let result = try JSONDecoder().decode(CoachResult.self, from: data)
            return result
        } catch {
            throw NetworkError.decodingError
        }
    }
}
