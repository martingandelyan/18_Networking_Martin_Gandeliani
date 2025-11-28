//
//  JsonDataCell.swift
//  18_Networking_Martin_Gandeliani
//
//  Created by Martin on 22.11.25.
//

import UIKit

class PostDataCell: UITableViewCell {
    private let titleLbl = UILabel()
    private let bodyLbl = UILabel()
    private let userIdLbl = UILabel()
    private let idLbl = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .gray
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        let cells = [titleLbl, bodyLbl, userIdLbl, idLbl]
            cells.forEach { cell in
            cell.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(cell)
        }
        
        titleLbl.numberOfLines = 0
        titleLbl.textAlignment = .center
        
        bodyLbl.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            idLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            idLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 5),
            
            userIdLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            userIdLbl.topAnchor.constraint(equalTo: idLbl.bottomAnchor, constant: 5),
            
            bodyLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bodyLbl.topAnchor.constraint(equalTo: userIdLbl.bottomAnchor, constant: 5),
            bodyLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bodyLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }

    func configure(data: Post) {
        titleLbl.text = data.title
        bodyLbl.text = data.body
        idLbl.text = "Post ID is \(data.id)"
        userIdLbl.text = "User ID is \(data.userId)"
    }
}

#Preview {
    PostsViewController()
}
