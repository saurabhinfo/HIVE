//
//  ViewController.swift
//  HIVE
//
//  Created by Saurabh Sharma on 03/01/24.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets

      @IBOutlet weak var tableView: UITableView!
      @IBOutlet weak var searchBar: UISearchBar!
      private var viewModel: MainViewModel!

      // MARK: - Properties

      var searchData: [Page] = []

      // MARK: - View Lifecycle

      override func viewDidLoad() {
          super.viewDidLoad()
          viewModel = MainViewModel()
          setupUI()
      }

      // MARK: - UI Setup

      func setupUI() {
          // Configure the search bar
          searchBar.delegate = self
          searchBar.placeholder = "Search"

          // Configure the table view
          tableView.delegate = self
          tableView.dataSource = self
          tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell") // Replace with your actual cell identifier
      }
  }

  // MARK: - UISearchBarDelegate

  extension ViewController: UISearchBarDelegate {
      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          viewModel.fetchData(withQuery: searchText) { result in
                      switch result {
                      case .success(let data):
                          do {
                                             let response = try JSONDecoder().decode(WikipediaResponse.self, from: data)
                                             self.searchData = response.query.pages.map { $0.value }
                                             self.tableView.reloadData()
                                         } catch {
                                             print("Error decoding JSON: \(error)")
                                         }
                      case .failure(let error):
                          // Handle the error
                          print("Error fetching data: \(error)")
                      }
                  }
      }
  }

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        let page = searchData[indexPath.row]
        cell.configure(withTitle: page.title, subtitle: page.extract, imageURL: URL(string: page.thumbnail?.source ?? ""))
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Implement logic to calculate dynamic cell height based on content
        return UITableView.automaticDimension
    }
}
