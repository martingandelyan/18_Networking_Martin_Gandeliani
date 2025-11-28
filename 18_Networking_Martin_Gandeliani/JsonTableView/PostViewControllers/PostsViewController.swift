//
//  ViewController.swift
//  18_Networking_Martin_Gandeliani
//
//  Created by Martin on 22.11.25.
//

import UIKit

struct Post: Decodable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}

class PostsViewController: UIViewController {
    private let addDataFromJsonBtn = UIButton()
    
    let postTableView = UITableView()
    var allPosts: [Post] = [
        Post(userId: 1, id: 1, title: "some text title", body: "some text body")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        setupDesign()
    }
    
    func setupDesign() {
        let views = [addDataFromJsonBtn, postTableView]
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        addDataFromJsonBtn.setTitle("მონაცემების დამატება", for: .normal)
        addDataFromJsonBtn.backgroundColor = .green
        addDataFromJsonBtn.layer.cornerRadius = 10
        addDataFromJsonBtn.setTitleColor(.black, for: .normal)
        addDataFromJsonBtn.addAction(UIAction(handler: { [weak self] action in
            self?.addPostDataPressed()
        }), for: .touchUpInside)
        
        postTableView.backgroundColor = .brown
        
        NSLayoutConstraint.activate([
            addDataFromJsonBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            addDataFromJsonBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            postTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postTableView.bottomAnchor.constraint(equalTo: addDataFromJsonBtn.topAnchor, constant: -10),
            postTableView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        postTableView.register(PostDataCell.self, forCellReuseIdentifier: "PostDataCell")
        postTableView.dataSource = self
        postTableView.delegate = self
    }
    
    private func getPostsFromUrl() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            print("data\(data, default: "") is loaded")
            
            do {
                let object = try JSONDecoder().decode([Post].self, from: data!)
                print(object)
                self.allPosts.append(contentsOf: object)
                //დისპათჩ ქიუზე ინფორმაცია მოვიძიე, რადგან მეორე დაჭერაზე გამოჰქონდა ინფორმაცია მხოლოდ
                DispatchQueue.main.async {
                    self.postTableView.reloadData()
                }
            } catch {
                print("decoding error")
            }
        }.resume()
    }
}

extension PostsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postDataCell = tableView.dequeueReusableCell(withIdentifier: "PostDataCell", for: indexPath) as! PostDataCell
        let allPostsArray = allPosts[indexPath.row]
        
        postDataCell.configure(data: allPostsArray)
        
        return postDataCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let posts = allPosts[indexPath.row]
        let commentVc = PostCommentViewController(postIdController: posts.id)
        navigationController?.pushViewController(commentVc, animated: true)
    }
    
    func addPostDataPressed() {
        //add action
        getPostsFromUrl()
        postTableView.reloadData()
    }
}

import SwiftUI

#Preview {
    PostsViewController()
}
