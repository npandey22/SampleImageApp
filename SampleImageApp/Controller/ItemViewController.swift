//
//  ViewController.swift
//  SampleImageApp
//
//  Created by Neha Pandey on 22/06/19.
//  Copyright © 2019 Neha Pandey. All rights reserved.
//

import UIKit
import SDWebImage

class ItemViewController: UIViewController {
    
    fileprivate let itemCellReuseIdentifier = "ItemTableViewCellIdentifier"
    fileprivate var tableView = UITableView()
    var pullToRefreshControl = UIRefreshControl()
    let viewModel = ItemViewModel()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.fetchDataFromAPI()
    }
    
    //MARK: - Navigation Bar Setup
    func setUpNavigationItem() {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.text = ItemCollection.sharedInstance.headerTitle
        titleLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        titleLabel.textAlignment = .center
        titleLabel.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        navigationItem.titleView = titleLabel
    }
    
    //MARK: - API Call to get Data
    @objc func fetchDataFromAPI() {
        viewModel.FetchResources()
        viewModel.showAlertClosure = {
            if let error = self.viewModel.error {
                print(error.localizedDescription)
            }
        }
        viewModel.completionHandler = {
            DispatchQueue.main.async {
                self.setUpNavigationItem()
                self.tableView.reloadData()
                self.pullToRefreshControl.endRefreshing()
            }
        }
    }
    
    // MARK: - UI Logic
    func configureTableView() {
        pullToRefreshControl.endRefreshing()
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: itemCellReuseIdentifier)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.tableFooterView = UIView()
        if #available(iOS 10.0, *) {
            tableView.refreshControl = pullToRefreshControl
        } else {
            tableView.addSubview(pullToRefreshControl)
        }
        pullToRefreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        pullToRefreshControl.attributedTitle = NSAttributedString(string: "Pull to Refresh ...")
        
        // Configure Refresh Control
        pullToRefreshControl.addTarget(self, action: #selector(fetchDataFromAPI), for: .valueChanged)
        
    }
    
}

// MARK: - TableView Data Source Methods
extension ItemViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemCollection.sharedInstance.row?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: itemCellReuseIdentifier, for: indexPath) as! ItemTableViewCell
        cell.selectionStyle = .none
        if ItemCollection.sharedInstance.row!.count > 0 {
            let item = ItemCollection.sharedInstance.row?[(indexPath as NSIndexPath).row] as! [String:AnyObject]
            cell.itemNameLabel.text = item["title"] as? String
            cell.itemDescriptionLabel.text = item["description"] as? String
            cell.itemImageView.sd_setImage(with: URL(string: item["imageHref"] as? String ?? ""), placeholderImage: #imageLiteral(resourceName: "PlaceholderImage"), completed: nil)
        }
        return cell
    }
}

