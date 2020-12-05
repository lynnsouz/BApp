//
//  ListStatementPresenterTests.swift
//  BankApp
//
//  Created by Lynneker Souza on 5/31/20.
//  Copyright (c) 2020 Lynneker Souza. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import BankApp
import XCTest

class ListStatementPresenterTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: ListStatementPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupListStatementPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupListStatementPresenter() {
        sut = ListStatementPresenter()
    }
    
    // MARK: Test doubles
    
    class ListStatementDisplayLogicSpy: ListStatementDisplayLogic {
        
        var displayFetchedStatementCalled = false
        var displayUserAccountInfoCalled = false
        
        func displayUserAccountInfo(viewModel: ListStatement.UserAccountInfo.ViewModel) {
            displayUserAccountInfoCalled = true
        }
        
        func displayFetchedStatement(viewModel: ListStatement.FetchStatement.ViewModel) {
            displayFetchedStatementCalled = true
        }
    }
    
    // MARK: Tests
    
    func testDisplayFetchedStatementCalled() {
        // Given
        let spy = ListStatementDisplayLogicSpy()
        sut.viewController = spy
        let response = ListStatement.FetchStatement.Response(statements: [])
        
        // When
        sut.presentFetchStatement(response: response)
        
        // Then
        XCTAssertTrue(spy.displayFetchedStatementCalled, "presentSomething(response:) should ask the view controller to display the result")
    }
    
    func testDisplayUserAccountInfoCalled() {
        // Given
        let spy = ListStatementDisplayLogicSpy()
        sut.viewController = spy
        let response = ListStatement.UserAccountInfo.Response(userAccount: Seeds.UserInfo.loggedAccount)
        
        // When
        sut.presentUserAccount(response: response)
        
        // Then
        XCTAssertTrue(spy.displayUserAccountInfoCalled, "presentSomething(response:) should ask the view controller to display the result")
    }
}
