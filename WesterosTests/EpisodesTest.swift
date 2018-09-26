//
//  EpisodesTest.swift
//  WesterosTests
//
//  Created by Javier Finez de Dios on 23/9/18.
//

import XCTest
@testable import Westeros

class EpisodesTest: XCTestCase {
    
    var s01: Season!
    var s02: Season!
    var s01e01: Episode!
    var s02e01: Episode!
    var s01Date: Date!
    var s02Date: Date!
    var s01e01copy: Episode!
    
    override func setUp() {
        super.setUp()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let s01Date = formatter.date(from: "17/04/2011")
        let s02Date = formatter.date(from: "01/04/2012")
        
        s01e01 = Episode( title: "Winter Is Coming", originalAirDate: s01Date!, season: nil )
        s01 = Season( name: "Season 1",  releaseDate: s01Date! )
        s01.add( episode: s01e01 )
        s02e01 = Episode( title: "The North Remembers", originalAirDate: s02Date!, season: nil )
        s02 = Season( name: "Season 2",   releaseDate: s02Date! )
        s02.add( episode: s02e01 )
        s01e01copy = Episode( title: "Winter Is Coming", originalAirDate: s01Date!, season: nil )
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEpisodeExists() {
        XCTAssertNotNil( s01e01 )
    }
    
    func testEpisodeEquatable() {
        XCTAssertEqual( s01e01, s01e01)
        XCTAssertNotEqual( s01e01, s02e01 )
        XCTAssertEqual( s01e01copy, s01e01copy )
    }
    
    func testEpisodeHashable() {
        XCTAssertNotNil( s01e01.hashValue )
    }
    func testEpisodeComparable() {
        XCTAssertLessThan( s01e01!, s02e01! )
    }
    func testEpisodeCustomStringConvertible() {
        XCTAssertEqual( s01e01.description, "Winter Is Coming, 17-04-2011" )
        XCTAssertEqual( s01e01.description, s01e01copy.description )
    }
    
}
