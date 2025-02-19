//
//  ClanMemberCell.swift
//  WFAPP
//
//  Created by Денис Ефименков on 19.02.2025.
//

import UIKit
import SnapKit

class ClanMemberCell: UITableViewCell {

    // Элементы интерфейса
    private let nicknameLabel = UILabel()
    private let rankIDLabel = UILabel()
    private let clanPointsLabel = UILabel()
    private let clanRoleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        // Настройка nicknameLabel
        nicknameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        nicknameLabel.textColor = .black

        // Настройка rankIDLabel
        rankIDLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        rankIDLabel.textColor = .gray

        // Настройка clanPointsLabel
        clanPointsLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        clanPointsLabel.textColor = .gray

        // Настройка clanRoleLabel
        clanRoleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        clanRoleLabel.textColor = .gray
    }

    private func setupConstraints() {
        // Вертикальный стек для nicknameLabel и rankIDLabel
        let leftStackView = UIStackView(arrangedSubviews: [nicknameLabel, rankIDLabel])
        leftStackView.axis = .vertical
        leftStackView.spacing = 4
        leftStackView.alignment = .leading

        // Вертикальный стек для clanPointsLabel и clanRoleLabel
        let rightStackView = UIStackView(arrangedSubviews: [clanPointsLabel, clanRoleLabel])
        rightStackView.axis = .vertical
        rightStackView.spacing = 4
        rightStackView.alignment = .trailing

        // Горизонтальный стек для объединения leftStackView и rightStackView
        let mainStackView = UIStackView(arrangedSubviews: [leftStackView, rightStackView])
        mainStackView.axis = .horizontal
        mainStackView.spacing = 16
        mainStackView.alignment = .center

        // Добавляем mainStackView в ячейку
        contentView.addSubview(mainStackView)

        // Верстка с помощью SnapKit
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }

    // Метод для настройки ячейки данными
    func configure(with member: Member) {
        nicknameLabel.text = member.nickname
        rankIDLabel.text = "Rank: \(member.rankID ?? "N/A")"
        clanPointsLabel.text = "Points: \(member.clanPoints ?? "N/A")"
        clanRoleLabel.text = member.clanRole?.rawValue
    }
}
