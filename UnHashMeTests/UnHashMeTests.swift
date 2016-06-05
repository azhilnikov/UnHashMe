//
//  UnHashMeTests.swift
//  UnHashMeTests
//
//  Created by Alexey on 4/06/2016.
//  Copyright © 2016 Alexey Zhilnikov. All rights reserved.
//

import XCTest
@testable import UnHashMe

class UnHashMeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testHash() {
        let alphabet = "acdegilmnoprstuw"
        let hash = Hash(alphabet: alphabet)
        
        // Test #1
        let text1 = "leepadg"
        let expectedHash1 = "680131659347"
        
        hash.generateFor(text1, completion: { (hash) in
            if nil == hash {
                XCTAssert(false, "Cannot generate hash in test1!")
            }
            else {
                XCTAssertEqual(expectedHash1, hash!, "Wrong hash in test1!")
            }
        })
        
        hash.restoreStringWithLength(text1.characters.count, from: Int(expectedHash1)!, completion: { (text) in
            if nil == text {
                XCTAssert(false, "Cannot restore text in test1!")
            }
            else {
                XCTAssertEqual(text!, text1, "Wrong text in test1!")
            }
        })
        
        // Test #2
        let text2 = "composite"
        let expectedHash2 = "914117715920704"
        
        hash.generateFor(text2, completion: { (hash) in
            if nil == hash {
                XCTAssert(false, "Cannot generate hash in test2!")
            }
            else {
                XCTAssertEqual(expectedHash2, hash!, "Wrong hash in test2!")
            }
        })
        
        hash.restoreStringWithLength(text2.characters.count, from: Int(expectedHash2)!, completion: { (text) in
            if nil == text {
                XCTAssert(false, "Cannot restore text in test2!")
            }
            else {
                XCTAssertEqual(text!, text2, "Wrong text in test2!")
            }
        })
        
        // Test #3
        let text3 = "promenade"
        let expectedHash3 = "945924806726376"
        
        hash.generateFor(text3, completion: { (hash) in
            if nil == hash {
                XCTAssert(false, "Cannot generate hash in test3!")
            }
            else {
                XCTAssertEqual(expectedHash3, hash!, "Wrong hash i test3!")
            }
        })
        
        hash.restoreStringWithLength(text3.characters.count, from: Int(expectedHash3)!, completion: { (text) in
            if nil == text {
                XCTAssert(false, "Cannot restore text in test3!")
            }
            else {
                XCTAssertEqual(text!, text3, "Wrong text in test3!")
            }
        })
    }
}
