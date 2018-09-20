//
//  Character.swift
//  Westeros
//
//  Created by Javier Finez on 20/09/2018.
//

import Foundation

final class Person {
    
    // Mark: - Properties
    let name: String
    let house: House
    private let _alias: String?
    
    var alias: String {
        get{
//            if let alias = _alias {
//                // Existe y esta guardado dentro de _alias
//                return alias
//            } else {
//                return ""
//            }
            return _alias ?? "" // Devuelveme _alias, si hay algo, y si no, ""
        }
    }
    
    // Mark: - Initialization
    init(name: String, alias: String? = nil, house: House) {
        self.name = name
        self._alias = alias
        self.house = house
    }
}

extension Person {
    var fullName: String {
        return "\(name) \(house.name)"
    }
}

extension Person {
    var proxyForEquality: String { // identificar ineqquivocamente a una person
        return "\(house.name)\(name)\(alias)".uppercased()
    }
    
    var proxyForComparison: String { // ordenar
        return fullName.uppercased()
    }
}

extension Person: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Person: Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
