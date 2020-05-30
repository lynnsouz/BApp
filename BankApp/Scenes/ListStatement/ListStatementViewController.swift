//
//  ListStatementViewController.swift
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

protocol ListStatementDisplayLogic: class
{
    func displayFetchedStatement(viewModel: ListStatement.FetchStatement.ViewModel)
}

class ListStatementViewController: UIViewController, ListStatementDisplayLogic, UITableViewDataSource, UITableViewDelegate
{
    
    var interactor: ListStatementBusinessLogic?
    var router: (NSObjectProtocol & ListStatementRoutingLogic & ListStatementDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ListStatementInteractor()
        let presenter = ListStatementPresenter()
        let router = ListStatementRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        startLoadingAnimation()
        fetchStatement()
    }
    
    // MARK: - Logout
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Fetch orders
    
    var displayedStatement: [ListStatement.FetchStatement.ViewModel.DisplayedStatement] = []
    var displayedStatementSection: [String] = []
    
    func fetchStatement()
    {
        let request = ListStatement.FetchStatement.Request()
        interactor?.fetchStatement(request: request)
    }
    
    func displayFetchedStatement(viewModel: ListStatement.FetchStatement.ViewModel)
    {
        self.displayedStatement = viewModel.displayedStatement
        viewModel.displayedStatement.forEach({self.displayedStatementSection.append($0.dateAsDate.monthAndYear)})
        self.displayedStatementSection = Array(Set(self.displayedStatementSection))
        self.displayedStatementSection.sort(by: {Date(fromStringPTBR: $0, format: "LLLL / yyyy")! > Date(fromStringPTBR: $1, format: "LLLL / yyyy")!})
        stopLoadingAnimation()
        tableView.reloadData()
    }
    
    // MARK: - Table view, data source and delegate
    
    @IBOutlet weak var tableView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return displayedStatementSection.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 42))
        if #available(iOS 13.0, *) {
            headerView.backgroundColor = .systemGray6
        } else {
            headerView.backgroundColor = .white
        }
        headerView.applyShadow()
        
        let label = UILabel()
        label.frame = CGRect.init(x: 0, y: 0, width: headerView.frame.width-16, height: headerView.frame.height-16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = displayedStatementSection.get(at: section)!
        label.font = UIFont.systemFont(ofSize: 17.0)
        
        headerView.addSubview(label)
        label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16.0).isActive = true
        label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: 0).isActive = true
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let monthAndYear = displayedStatementSection.get(at: section) else { return 0 }
        return displayedStatement.filter({$0.dateAsDate.monthAndYear == monthAndYear}).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let monthAndYear = displayedStatementSection.get(at: indexPath.section),
            let statement = displayedStatement.filter({$0.dateAsDate.monthAndYear == monthAndYear}).get(at: indexPath.row),
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatementTableViewCell") as? StatementTableViewCell else {
                return UITableViewCell()
        }
        
        cell.statement = statement
        return cell
    }
    
}
