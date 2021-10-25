//
//  The_GuardianTests.swift
//  The GuardianTests
//
//  Created by Pyramid on 24/10/21.
//

import XCTest
@testable import The_Guardian

class The_GuardianTests: XCTestCase {

    //MARK: - Variable Declarations
    var webServiceHelper: NetworkManager!
    var viewModelObj: NewsListModelView!

    override func setUpWithError() throws {
        webServiceHelper = NetworkManager()
        viewModelObj = NewsListModelView()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Networkmanager_With_ValidRequest_Returns_NewsDataResponse()
    {
        //Arrange
        let expectation = self.expectation(description: "ValidRequest_Returns_NewsDataResponse")
        
        // Act
        NetworkManager.GETMethodRequestWithKey(CountryName: "Afghanistan") { result in
            
            let resultFromJSONParse = self.viewModelObj.parseJSON(result ?? Data())
            
            self.viewModelObj.insertNewData(resultFromJSONParse)
            {
                self.viewModelObj.fetchNewsData { value in
                    
                    //Assert
                    XCTAssertNotNil(value)
                    XCTAssertNotEqual(0, value.count)
                    
                }
                
                //Assert
                XCTAssertNotNil(resultFromJSONParse)
                
            }
            //Assert
            XCTAssertNotNil(result)
            
            expectation.fulfill()
            
        } Failure: { error in
            XCTAssertNil(error)
            expectation.fulfill()
            
        }
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    
    func test_Networkmanager_With_InvalidRequest_Returns_NewsDataResponse()
    {
        //Arrange
        let expectation = self.expectation(description: "InvalidRequest_Returns_NewsDataResponse")
        
        // Act
        NetworkManager.GETMethodRequestWithKey(CountryName: "dsdgfhjs") { result in
            
            let resultFromJSONParse = self.viewModelObj.parseJSON(result ?? Data())
            
            self.viewModelObj.insertNewData(resultFromJSONParse) {
                self.viewModelObj.fetchNewsData { value in
                    
                    //Assert
                    XCTAssertEqual(0, value.count)
                    
                }
            }
            //Assert
            XCTAssertNotNil(result)
            XCTAssertEqual(0, resultFromJSONParse.count)
            expectation.fulfill()
            
        } Failure: { error in
            XCTAssertNil(error)
            expectation.fulfill()
            
        }
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
}

