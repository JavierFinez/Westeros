//
//  RepositoryTests.swift
//  WesterosTests
//
//  Created by Javier Finez on 20/09/2018.
//

import XCTest
@testable import Westeros

class RepositoryTests: XCTestCase {

    var localHouses: [House]!
    var localSeasons: [Season]!
    
    override func setUp() {
        localHouses = Repository.local.houses
        localSeasons = Repository.local.seasons
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocalRepositoryExistence() {
        XCTAssertNotNil(Repository.local)
    }

    func testLocalRepositoryHousesCreation() {
        XCTAssertNotNil(localHouses)
        XCTAssertEqual(localHouses.count, 3)
    }
    
    func testLocalRepositoryReturnsSortedArrayOfHouses() {
        XCTAssertEqual(localHouses, localHouses.sorted())
    }
    
    func testLocalRepositoryReturnsHousesByNameCaseInsensitively() {
        let stark = Repository.local.house(named: "sTaRk")
        
        XCTAssertEqual(stark?.name, "Stark")
        
        let keepcoding = Repository.local.house(named: "Keepcoding")
        XCTAssertNil(keepcoding)
    }
    
    func testLocalRepositoryHouseFiltering() {
//        let filtered = Repository.local.houses(filteredBy: { $0.count == 1 })
        var filtered = Repository.local.houses { $0.count == 1 }
        XCTAssertEqual(filtered.count, 1)
        
        filtered = Repository.local.houses { $0.count == 100 }
        XCTAssertTrue(filtered.isEmpty)
    }
    
    func testLocalRepositorySeasonFiltering() {
        let filtered = Repository.local.seasons { $0.count == 2 }
        XCTAssertEqual(filtered.count, 7)
        
        let filtered2 = Repository.local.seasons { $0.count == 100000 }
        XCTAssertTrue(filtered2.isEmpty)
    }

}
