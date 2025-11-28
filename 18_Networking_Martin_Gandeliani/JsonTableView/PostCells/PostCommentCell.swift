//
//  PostCommentCell.swift
//  18_Networking_Martin_Gandeliani
//
//  Created by Martin on 23.11.25.
//

import UIKit

class PostCommentCell: UITableViewCell {
    private let commentSection = UILabel()
    private let postIdSection = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupDesign()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDesign() {
        contentView.addSubview(commentSection)
        commentSection.translatesAutoresizingMaskIntoConstraints = false
        commentSection.numberOfLines = 0
        
        contentView.addSubview(postIdSection)
        postIdSection.translatesAutoresizingMaskIntoConstraints = false
        postIdSection.textAlignment = .center
        
        NSLayoutConstraint.activate([
            postIdSection.topAnchor.constraint(equalTo: contentView.topAnchor),
            postIdSection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postIdSection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            commentSection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            commentSection.topAnchor.constraint(equalTo: postIdSection.bottomAnchor, constant: 5),
            commentSection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
    
    func configureComment(comment: Comment) {
        commentSection.text = comment.body
        postIdSection.text = "Post ID is \(comment.postId)"
    }
}
