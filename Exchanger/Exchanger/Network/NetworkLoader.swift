//
//
//

import Foundation


class NetworkLoader {
    
    func change(model: ChangeModel) async throws -> Result {
        let path = makePath(model: model)
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
    
    private func makePath(model: ChangeModel) -> String {
        let key = "df485b82aade27b84231b6b91adf27e0"
        let path = "https://api.exchangeratesapi.io/v1/convert"
        return path + "?" + "access_key=\(key)" + "&from=\(model.from.rawValue)" + "&to=\(model.to.rawValue)" + "&amount=\(model.amount)"
    }
    
}

//https://api.exchangeratesapi.io/v1/convert?access_key=df485b82aade27b84231b6b91adf27e0&from=USD&to=GBP&amount=33.0
//https://api.exchangeratesapi.io/v1/convert?access_key = API_KEY&from=GBP&to=JPY&amount=25


