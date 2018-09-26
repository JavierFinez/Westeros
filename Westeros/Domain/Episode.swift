//
//  Episode.swift
//  Westeros
//
//  Created by Javier Finez de Dios on 23/9/18.
//

import Foundation

//MARK: - class
final class Episode {
    
    let title: String
    let originalAirDate: Date
    // Aquí tenemos cuidado con crear referencias circulares.
    weak var season: Season?
    
    init(title: String, originalAirDate: Date, season: Season?) {
        self.title = title
        self.originalAirDate = originalAirDate
        self.season = season
    }
    
}

extension Episode {
    var stringDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: originalAirDate)
    }
}


extension Episode: CustomStringConvertible {
    var description: String {
        return "\(title), \(stringDate)"
    }
    
}

extension Episode:Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Episode {
    var proxyForEquality: String {
        return "\(title) \(originalAirDate)"
    }
    var proxyForComparison: Date {
        return originalAirDate
    }
}

extension Episode: Equatable {
    static func ==(lhs:Episode, rhs:Episode) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Episode: Comparable {
    static func <(lhs:Episode,rhs:Episode) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
