//
//  Season.swift
//  Westeros
//
//  Created by Javier Finez de Dios on 23/9/18.
//

import UIKit

typealias Episodes = Set<Episode>

final class Season {
    
    let name: String
    let releaseDate:Date
    private var _episodes: Episodes
    
    init(name: String, releaseDate: Date) {
        self.name = name
        self.releaseDate = releaseDate
        _episodes = Episodes()
    }
}


extension Season {
    func add(episode:Episode) {
        _episodes.insert(episode)
    }
    var stringDate:String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: releaseDate)
    }
    var sortedEpisodes: [Episode] {
        return _episodes.sorted()
    }
    var count:Int {
        return _episodes.count
    }
}


extension Season: CustomStringConvertible {
    var description: String {
        return "\(name), \(stringDate), \(_episodes.count)"
    }
}

extension Season:Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Season {
    var proxyForEquality: String {
        return "\(name) \(stringDate)"
    }
    
    var proxyForComparison: Date {
        return releaseDate
     }
}

extension Season: Equatable {
    static func ==(lhs:Season, rhs:Season)->Bool{
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Season: Comparable {
    static func <(lhs:Season,rhs:Season)->Bool{
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
