//
//  CustomCell.swift
//  WFAPP
//
//  Created by Денис Ефименков on 19.02.2025.
//

import UIKit
import SnapKit

class CustomCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let mainLabel: UILabel = {
        let name = UILabel()
        name.numberOfLines = 0
        name.textAlignment = .left
        return name
    }()
    let secondLabel: UILabel = {
        let name = UILabel()
        name.numberOfLines = 0
        name.textAlignment = .left
        name.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        name.textColor = .gray
        return name
    }()
    let rankLabel: UILabel = {
        let name = UILabel()
        name.numberOfLines = 0
        name.textAlignment = .left
        return name
    }()
    let imageForCell: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 8
        return sv
    }()

    
    func setupUI(){
        // Создаем вертикальный stackView для mainLabel и secondLabel
        let labelsStackView = UIStackView(arrangedSubviews: [mainLabel, secondLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 4
        labelsStackView.alignment = .leading

        // Создаем горизонтальный stackView для imageForCell, labelsStackView и rankLabel
        let mainStackView = UIStackView(arrangedSubviews: [imageForCell, labelsStackView, rankLabel])
        mainStackView.axis = .horizontal
        mainStackView.spacing = 16
        mainStackView.alignment = .center

        // Добавляем mainStackView в ячейку
        contentView.addSubview(mainStackView)

        // Верстка с помощью SnapKit
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16) // Отступы от краев ячейки
        }

        imageForCell.snp.makeConstraints { make in
            make.width.height.equalTo(80) // Фиксированный размер изображения
        }

        rankLabel.snp.makeConstraints { make in
            make.width.equalTo(40) // Фиксированная ширина для rankLabel
        }
    }
}
