//
//  HelloWorldViewModelTests.swift
//  Hello-WorldTests
//
//  Created by Md. Rohejul Islam on 9/28/24.
//

import XCTest

final class HelloWorldViewModelTests: XCTestCase {
    
    var viewModel: HelloWorldViewModel!
    private var mockAPI: MockHelloWorldAPI!
    
    @MainActor
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockAPI = MockHelloWorldAPI()
        viewModel = HelloWorldViewModel(helloWorldAPI: mockAPI)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        mockAPI = nil
    }
    
    
    @MainActor
    func testFetchHelloWorld() throws {
        XCTAssertNotNil(viewModel)
        // Act: Create an expectation to wait for the async operation
        let expectation = XCTestExpectation(description: "Fetch Hello World")
        
        // Observe changes to the `helloWorld` property
        let cancellable = viewModel.$helloWorld.sink { helloWorld in
            if helloWorld != nil {
                expectation.fulfill() // Complete the expectation when helloWorld is set
            }
        }
        
        viewModel.fetchHelloWorld()
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 15.0)
        
        XCTAssertNotNil(viewModel.helloWorld)
        XCTAssertEqual(viewModel.helloWorld?.message, "Hello, World!")
        XCTAssertNil(viewModel.errorMessage)
        
        cancellable.cancel() // Cancel the observation after the test
    }
    
    @MainActor
    func testFetchHelloWorldFailure() {
        XCTAssertNotNil(viewModel)
        
        // Act: Create an expectation to wait for the async operation
        let expectation = XCTestExpectation(description: "Fetch Hello World Error")
        
        // Observe changes to the `errorMessage` property
        let cancellable = viewModel.$errorMessage.sink { errorMessage in
            if errorMessage != nil {
                expectation.fulfill() // Complete the expectation when errorMessage is set
            }
        }
        
        // Call the method to fetch error response
        mockAPI.shouldReturnError = true
        viewModel.fetchHelloWorld()
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
        
        // Assert: Verify that an error occurred
        XCTAssertNil(viewModel.helloWorld)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage, NetworkError.invalidResponse.localizedDescription)
        
        cancellable.cancel() // Cancel the observation after the test
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
