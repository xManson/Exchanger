//
//  Errors.swift


import Foundation

enum TError: Error {
    case wrongURL
    case amountWrong
    case someWrong
}

extension TError: CustomStringConvertible {
    public var description: String {
        switch self {
            
        case .wrongURL: return "We're sorry, but market url is wrong"
        case .amountWrong: return "wrong amount"
        case .someWrong: return "Exchanging went wrong"
            
        }
    }
}
