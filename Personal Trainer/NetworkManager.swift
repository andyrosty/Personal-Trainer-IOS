//
//  NetworkManager.swift
//  Personal Trainer
//
//  Created by Andrew Acheampong on 5/28/25.
//

import Foundation

// AWS Authentication credentials
struct AWSCredentials {
    let accessKey: String
    let secretKey: String
    let region: String
}

enum NetworkError: LocalizedError {
    case invalidURL
    case badResponse(statusCode: Int)
    case decodingError
    case missingCredentials
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid server URL."
        case .badResponse(let code):
            return "Server returned status code \(code)."
        case .decodingError:
            return "Failed to decode response."
        case .missingCredentials:
            return "AWS credentials are required but not configured."
        case .unknown(let err):
            return err.localizedDescription
        }
    }
}



final class NetworkManager {
    static let shared = NetworkManager()

    // FastAPI backend endpoint hosted on AWS for fitness plan generation
    private let baseURL = "https://api.example.com/v1"

    // AWS credentials
    private var awsCredentials: AWSCredentials?

    private init() {}

    // Configure AWS credentials
    func configure(with credentials: AWSCredentials) {
        self.awsCredentials = credentials
    }

    // Helper method to get AWS credential scope
    private func getCredentialScope(region: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateStamp = dateFormatter.string(from: Date())
        return "\(dateStamp)/\(region)/execute-api/aws4_request"
    }

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

        // Add AWS authentication if credentials are available
        // This is needed for the FastAPI backend hosted on AWS
        if let credentials = awsCredentials {
            // Add timestamp for AWS request
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.formatOptions = [.withInternetDateTime]
            let timestamp = dateFormatter.string(from: Date())
            request.setValue(timestamp, forHTTPHeaderField: "X-Amz-Date")

            // Add AWS authorization header
            // Note: A complete implementation would require calculating the signature using HMAC-SHA256
            // This is a simplified version for demonstration purposes
            let credentialScope = getCredentialScope(region: credentials.region)
            let authHeader = "AWS4-HMAC-SHA256 " +
                            "Credential=\(credentials.accessKey)/\(credentialScope), " +
                            "SignedHeaders=content-type;host;x-amz-date, " +
                            "Signature=SIGNATURE_PLACEHOLDER"
            request.setValue(authHeader, forHTTPHeaderField: "Authorization")

            // Add AWS region header
            request.setValue(credentials.region, forHTTPHeaderField: "X-Amz-Region")
        }

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
