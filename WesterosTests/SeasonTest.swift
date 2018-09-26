//
//  SeasonTest.swift
//  WesterosTests
//
//  Created by Javier Finez de Dios on 23/9/18.
//

import XCTest
@testable import Westeros

class SeasonTest: XCTestCase {
    
    var s01: Season!
    var s02: Season!
    var s01e01: Episode!
    var s02e01: Episode!
    var s01Date: Date!
    var s02Date: Date!
    var s01copy: Season!
    
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
        
        s01copy = Season( name: "Season 1",  releaseDate: s01Date! )
        s01copy.add(episode: s01e01)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSeasonExistence() {
        XCTAssertNotNil( s01)
    }
    
    func testSeasonHasEpisode() {
        XCTAssertGreaterThan( s01.count, 0 )
    }
    
    func testSeasonEquatable() {
        XCTAssertEqual( s01, s01 )
        XCTAssertNotEqual( s01, s02 )
        XCTAssertEqual( s01, s01copy )
    }
    
    func testSeasonHashable() {
        XCTAssertNotNil(s01.hashValue)
    }
    func testSeasonComparable(){
        XCTAssertLessThan(s01!, s02!)
    }
    
    func testSeasonCustomStringConvertible() {
        XCTAssertEqual( s01.description, "Season 1, 17-04-2011, 1" )
    }
    
    
}
