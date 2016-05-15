//
//  SixStringsTests.swift
//  SixStringsTests
//
//  Created by sean on 5/10/16.
//  Copyright © 2016 Sean Johnsen. All rights reserved.
//

import XCTest
@testable import SixStrings

class SixStringsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testChordPairEquality() {
        let firstChord = ChordPair(.A, .E)
        let secondChord = ChordPair(.A, .E)
        let thirdChord = ChordPair(.E, .A)
        XCTAssertEqual(firstChord, secondChord)
        XCTAssertEqual(firstChord, thirdChord)
    }
    
    func testChordPairEncodingDecoding() {
        let chordPair = ChordPair(Chord.A, Chord.E)
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(chordPair)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "chordPair")
        
        if let savedData = NSUserDefaults.standardUserDefaults().objectForKey("chordPair") as? NSData {
            let decodedPair = NSKeyedUnarchiver.unarchiveObjectWithData(savedData) as? ChordPair
            
            XCTAssertEqual(chordPair, decodedPair)
        } else {
            XCTFail()
        }
    }
    
    func testListChordPairEncodingDecoding() {
        let chordPairs = [ChordPair(.A, .E), ChordPair(.G, .C), ChordPair(.D, .A)]
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(chordPairs)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "chordPairs")
        
        if let savedData = NSUserDefaults.standardUserDefaults().objectForKey("chordPairs") as? NSData {
            let decodedPairs = NSKeyedUnarchiver.unarchiveObjectWithData(savedData) as? [ChordPair]
            
            XCTAssertEqual(chordPairs, decodedPairs)
        }
    }
    
    func testUserEncodingDecoding() {
        let user = User()
        user.incrementStage()
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(user)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "user")
        
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("user") as? NSData {
            let decodedUser = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? User
            
            XCTAssertEqual(user, decodedUser)
        }
    }
}
