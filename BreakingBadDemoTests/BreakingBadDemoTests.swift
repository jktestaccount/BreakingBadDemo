//
//  BreakingBadDemoTests.swift
//  BreakingBadDemoTests
//
//  Created by Juan Kruger on 05/08/2021.
//

import XCTest
@testable import BreakingBadDemo

class BreakingBadDemoTests: XCTestCase {

    // Note this is testing a live download - production app to use bundled json response for testing
    func testCharactersDownloadAndParse() throws {
       
        let e = expectation(description: "CharsDownload")
        
        let viewModel = CharactersViewModel()
        
        viewModel.charactersViewModels.bind { characterViewModels in
            
            // Ensure download completes and models are properly populated
            if let characterViewModel = characterViewModels.first, characterViewModel.name.value.count > 0 {
                
                e.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }

}
