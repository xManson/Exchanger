//
//  Exchange.swift
//  Exchanger
//

import Foundation

class Exchange {
    
    private let network = NetworkLoader()
    var model = ChangeModel()
    
    func perform() async throws -> Result {
        try await network.change(model: model)
    }
    
}
