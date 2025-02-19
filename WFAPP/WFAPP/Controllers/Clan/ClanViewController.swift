//
//  ClanViewController.swift
//  WFAPP
//
//  Created by Денис Ефименков on 19.02.2025.
//

import UIKit
import SnapKit

class ClanViewController: UIViewController, UITableViewDelegate {

    private let viewModel = ClanViewModel()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        fetchData()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        navigationItem.title = "Title"
        // Верстка с помощью SnapKit
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // Настройка таблицы
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func fetchData() {
        viewModel.fetchClans { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

// Реализация UITableViewDataSource
extension ClanViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfClans()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        let clans = viewModel.clanAtIndex(indexPath.row)
        cell.mainLabel.text = clans.clan
        cell.rankLabel.text = clans.rank
        cell.secondLabel.text = "Clan Leader: \(clans.clanLeader!)"
        cell.imageForCell.image = UIImage(named: "wf")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedClanName = viewModel.clanAtIndex(indexPath.row).clan
        let cvc = ClanMembersViewController(nameOfClan: selectedClanName!)
        present(cvc, animated: true)
    }
}
