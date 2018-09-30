//
//  Respository.swift
//  Westeros
//
//  Created by Javier Finez on 20/09/2018.
//

import UIKit

final class Repository {
    static let local = LocalFactory()
}

protocol HouseFactory {
    typealias Filter = (House) -> Bool
    
    var houses: [House] { get }
    
    func house(named: String) -> House?
    
    func houses(filteredBy filter: Filter) -> [House]
}

protocol SeasonFactory {
    typealias FilterSeason = (Season) -> Bool
  
    var seasons: [Season] { get }
    
    func seasons( filteredBy: FilterSeason ) -> [Season]
}

final class LocalFactory: HouseFactory {
    
    var houses: [House] {
    
        // Houses creation here
        let starkSigil = Sigil(image: UIImage(named: "codeIsComing.png")!, description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: UIImage(named: "lannister.jpg")!, description: "Leon Rampante")
        let targaryenSigil = Sigil(image: UIImage(named: "targaryenSmall.jpg")!, description: "Dragon tricefalo")

        let starkUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        let targaryenUrl = URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: starkUrl)
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: lannisterUrl)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y Sangre", url: targaryenUrl)
        
        // Characters creation
        let robb = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "El enano", house: lannisterHouse)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let jaime = Person(name: "Jaime", alias: "El matarreyes", house: lannisterHouse)
        let dani = Person(name: "Daenerys", alias: "Madre de dragones", house: targaryenHouse)
        
        // Add characters to houses
        starkHouse.add(persons: arya, robb)
        lannisterHouse.add(persons: tyrion, jaime, cersei)
        targaryenHouse.add(person: dani)
        
        
        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        return houses.first { $0.name.uppercased() == name.uppercased() }
    }
    
    func houses(filteredBy: Filter) -> [House] {
        return houses.filter(filteredBy)
    }
    
    enum Houses: String {
        case Stark = "Stark"
        case Lannister = "Lannister"
        case Targaryen = "Targaryen"
    }
    
    func house(named enumHouse: Houses) -> House? {
        return house(named: enumHouse.rawValue)
    }
    
}

extension LocalFactory: SeasonFactory{
    var seasons: [Season] {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        //MARK: - Season One
        let s01Date = formatter.date(from: "17/04/2011")
        let s01e01Date = formatter.date(from: "17/04/2011")
        let s01e02Date = formatter.date(from: "24/04/2011")
        let s01e01 = Episode( title: "Winter Is Coming", originalAirDate: s01e01Date!, season: nil )
        let s01e02 = Episode( title: "The Kingsroad", originalAirDate: s01e02Date!, season: nil )
        let s01 = Season( name: "Season 1",  releaseDate: s01Date! )
        s01.add( episode: s01e01 )
        s01.add( episode: s01e02 )
        
        //MARK: - Season Two
        let s02Date = formatter.date(from: "01/04/2012")
        let s02e01Date = formatter.date(from: "01/04/2012")
        let s02e02Date = formatter.date(from: "08/04/2012")
        let s02e01 = Episode( title: "The North Remembers", originalAirDate: s02e01Date!, season: nil )
        let s02e02 = Episode( title: "The Night Lands", originalAirDate: s02e02Date!, season: nil )
        let s02 = Season( name: "Season 2",  releaseDate: s02Date! )
        s02.add( episode: s02e01 )
        s02.add( episode: s02e02 )
        
        //MARK: - Season Three
        let s03Date = formatter.date(from: "31/03/2013")
        let s03e01Date = formatter.date(from: "31/03/2013")
        let s03e02Date = formatter.date(from: "07/04/2013")
        let s03e01 = Episode( title: "Valar Dohaeris", originalAirDate: s03e01Date!, season: nil )
        let s03e02 = Episode( title: "Dark Wings, Dark Words", originalAirDate: s03e02Date!, season: nil )
        let s03 = Season( name: "Season 3",  releaseDate: s03Date! )
        s03.add( episode: s03e01 )
        s03.add( episode: s03e02 )
        
        //MARK: - Season Four
        let s04Date = formatter.date(from: "06/04/2014")
        let s04e01Date = formatter.date(from: "06/04/2014")
        let s04e02Date = formatter.date(from: "13/04/2014")
        let s04e01 = Episode( title: "Two Swords", originalAirDate: s04e01Date!, season: nil )
        let s04e02 = Episode( title: "The Lion and the Rose", originalAirDate: s04e02Date!, season: nil )
        let s04 = Season( name: "Season 4",  releaseDate: s04Date! )
        s04.add( episode: s04e01 )
        s04.add( episode: s04e02 )
        
        //MARK: - Season Five
        let s05Date = formatter.date(from: "12/04/2015")
        let s05e01Date = formatter.date(from: "12/04/2015")
        let s05e02Date = formatter.date(from: "19/04/2015")
        let s05e01 = Episode( title: "The Wars to Come", originalAirDate: s05e01Date!, season: nil )
        let s05e02 = Episode( title: "The House of Black and White", originalAirDate: s05e02Date!, season: nil )
        let s05 = Season( name: "Season 5",  releaseDate: s05Date! )
        s05.add( episode: s05e01 )
        s05.add( episode: s05e02 )
        
        //MARK: - Season Six
        let s06Date = formatter.date(from: "24/04/2016")
        let s06e01Date = formatter.date(from: "24/04/2016")
        let s06e02Date = formatter.date(from: "01/05/2016")
        let s06e01 = Episode( title: "The Red Woman", originalAirDate: s06e01Date!, season: nil )
        let s06e02 = Episode( title: "Home", originalAirDate: s06e02Date!, season: nil )
        let s06 = Season( name: "Season 6",  releaseDate: s06Date! )
        s06.add( episode: s06e01 )
        s06.add( episode: s06e02 )
        
        //MARK: - Season Seven
        let s07Date = formatter.date(from: "16/06/2017")
        let s07e01Date = formatter.date(from: "16/06/2017")
        let s07e02Date = formatter.date(from: "23/06/2017")
        let s07e01 = Episode( title: "Dragonstone", originalAirDate: s07e01Date!, season: nil )
        let s07e02 = Episode( title: "Stormborn", originalAirDate: s07e02Date!, season: nil )
        let s07 = Season( name: "Season 7",  releaseDate: s07Date! )
        s07.add( episode: s07e01 )
        s07.add( episode: s07e02 )
        
        return [s01, s02, s03, s04, s05, s06, s07].sorted()
    }
    
    func seasons(filteredBy: FilterSeason) -> [Season] {
        return seasons.filter(filteredBy)
    }
}
