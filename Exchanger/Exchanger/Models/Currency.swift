//
//  Model.swift
//

import Foundation


enum Currency: String, CaseIterable {
    case USD
    case GBP
    case EUR
    
    var intVal: Int {
        Currency.allCases.firstIndex(where: { $0 == self }) ?? 0
    }

}



