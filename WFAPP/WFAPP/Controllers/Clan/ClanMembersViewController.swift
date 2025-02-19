//
//  ClanMembers.swift
//  WFAPP
//
//  Created by Денис Ефименков on 19.02.2025.
//

import UIKit

class ClanMembersViewController: UIViewController {

    private let nameOfClan: String

    init(nameOfClan: String) {
        self.nameOfClan = nameOfClan
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Данные для таблицы
    private var clanMembersModel: ClanMembersModel?
    private var clanName: ClanModelElement?
    private var officers: [Member] = []
    private var regulars: [Member] = []
    private var masters: [Member] = []
    // Таблица
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupData() // Загружаем данные при загрузке экрана
    }

    public func setupData() {
        // URL API (замените на ваш реальный URL)
        guard let url = URL(string: "\(ApiManager.clanMembersApi)" + "\(nameOfClan)") else {
            print("Invalid URL")
            return
        }

        // Создаем задачу для загрузки данных
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            // Проверяем наличие ошибок
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }

            // Проверяем, что данные получены
            guard let data = data else {
                print("No data received")
                return
            }

            // Декодируем данные
            do {
                let decoder = JSONDecoder()
                let clanMembersModel = try decoder.decode(ClanMembersModel.self, from: data)

                // Обновляем данные на главном потоке
                DispatchQueue.main.async {
                    self?.clanMembersModel = clanMembersModel

                    // Разделяем участников на офицеров и обычных
                    if let members = clanMembersModel.members {
                        self?.officers = members.filter { $0.clanRole == .officer }
                        self?.regulars = members.filter { $0.clanRole == .regular }
                    }

                    // Обновляем таблицу
                    self?.tableView.reloadData()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }

        // Запускаем задачу
        task.resume()
    }

    private func setupTableView() {
        // Настройка таблицы
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ClanMemberCell.self, forCellReuseIdentifier: "ClanMemberCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80

        // Добавляем таблицу на экран
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// Реализация UITableViewDataSource и UITableViewDelegate
extension ClanMembersViewController: UITableViewDataSource, UITableViewDelegate {

    // Количество секций
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    // Заголовок секции
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "MASTER" : (section == 1 ? "OFFICER" : "REGULAR")
    }

    // Количество строк в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? masters.count : (section == 1 ? officers.count : regulars.count)
    }

    // Настройка ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClanMemberCell", for: indexPath) as! ClanMemberCell

        let member = indexPath.section == 0 ? masters[indexPath.row] :
                     indexPath.section == 1 ? officers[indexPath.row] :
                     regulars[indexPath.row]

        cell.configure(with: member)
        return cell
    }
}
