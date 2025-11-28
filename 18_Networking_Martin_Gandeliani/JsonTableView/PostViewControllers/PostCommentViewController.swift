//
//  PostCommentViewController.swift
//  18_Networking_Martin_Gandeliani
//
//  Created by Martin on 23.11.25.
//

import UIKit

struct Comment: Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}

class PostCommentViewController: UIViewController {
    var allPostComments: [Comment] = []
    let postCommentTableView = UITableView()
    private var postIdController: Int
    
        init (postIdController: Int) {
        self.postIdController = postIdController
        print(self.postIdController)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
        gainCommentFromJson()

        postCommentTableView.register(PostCommentCell.self, forCellReuseIdentifier: "PostCommentCell")
        postCommentTableView.dataSource = self
        postCommentTableView.delegate = self
    }
    
    func setupDesign() {
        view.addSubview(postCommentTableView)
        postCommentTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            postCommentTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postCommentTableView.topAnchor.constraint(equalTo: view.topAnchor),
            postCommentTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            postCommentTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func gainCommentFromJson() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments") else { return }
        
        URLSession.shared.dataTask(with: url) { data, URLResponse, error in
            do {
                let data = data
                self.allPostComments = try JSONDecoder().decode([Comment].self, from: data!)
                let filteredPost = self.allPostComments.filter { $0.postId == self.postIdController }
                DispatchQueue.main.async {
                                self.allPostComments = filteredPost
                                self.postCommentTableView.reloadData()
                            }
            } catch {
                print("error with decoding")
            }
        }.resume()
    }
}

extension PostCommentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allPostComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCommentCell", for: indexPath) as! PostCommentCell
        
        let comments = allPostComments[indexPath.row]
        cell.configureComment(comment: comments)
        
        return cell
    }
}
