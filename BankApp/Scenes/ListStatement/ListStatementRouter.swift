//
//  ListStatementRouter.swift
//  BankApp
//
//  Created by Lynneker Souza on 5/29/20.
//  Copyright (c) 2020 Lynneker Souza. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol ListStatementRoutingLogic {
  func routeBackToLogin()
}

protocol ListStatementDataPassing {
  var dataStore: ListStatementDataStore? { get }
}

class ListStatementRouter: NSObject, ListStatementRoutingLogic, ListStatementDataPassing {
  weak var viewController: ListStatementViewController?
  var dataStore: ListStatementDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}
    
    func routeBackToLogin() {
        navigateToLogin(source: viewController!)
    }

  // MARK: Navigation
  
  func navigateToLogin(source: ListStatementViewController)
  {
    source.navigationController?.popViewController(animated: true)
  }
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: ListStatementDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
