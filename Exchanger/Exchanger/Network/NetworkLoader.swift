//
//
//

import Foundation


class NetworkLoader {
    
    
    func change(from: Currency, to: Currency, amount: Double) async throws -> Result {
        let path = makePath(from: from, to: to, amount: amount)
        guard let url = URL(string: path) else {
            throw TError.wrongURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let result = try decoder.decode(Result.self, from: data)
        guard result.success else {
            throw TError.someWrong
        }
        return result
    }
    
    private func makePath(from: Currency, to: Currency, amount: Double) -> String {
        let key = "df485b82aade27b84231b6b91adf27e0"
        let path = "https://api.exchangeratesapi.io/v1/convert"
        return path + "?" + "access_key=\(key)" + "&from=\(from.rawValue)" + "&to=\(to.rawValue)" + "&amount=\(amount)"
    }
    
}
