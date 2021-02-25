//
//  ViewController.swift
//  News
//
//  Created by Mahesha on 24/02/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewSwitch: UIBarButtonItem!
    
    private var dataSource: [Article] = []
    private var listFlowLayout = ListFlowLayout()
    private var gridFlowLayout = GridFlowLayout()
    private var isListView = true
    private var shouldRefresh = true

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = listFlowLayout
        registerToNib()
        getData()
        
    }
    
    func registerToNib() {
        collectionView.register(UINib(nibName: NewsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: NewsCollectionViewCell.identifier)
    }
    
    func getData() {
        NewsManager.shared.getNews { [weak self](articles, error) in
            guard let weakSelf = self else {
                return
            }
            if error == nil {
                guard let theArticles = articles else {
                    return
                }
                weakSelf.dataSource.append(contentsOf: theArticles.articles)
                if weakSelf.dataSource.count == theArticles.totalResults {
                    weakSelf.shouldRefresh = false
                }
                DispatchQueue.main.async {
                    weakSelf.collectionView.reloadData()
                }
                
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: error?.errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
                    weakSelf.present(alert, animated: true, completion: nil)
                }
               
            }
            
        }
    }
    
    func updateView() {
        isListView = isListView ? false : true
        if isListView {
            viewSwitch.image = #imageLiteral(resourceName: "grid")
            collectionView.collectionViewLayout = listFlowLayout
        } else {
            viewSwitch.image = #imageLiteral(resourceName: "list")
            collectionView.collectionViewLayout = gridFlowLayout
        }
    }
    
    @IBAction func toggleView(_ sender: Any) {
        updateView()
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.identifier, for: indexPath) as!NewsCollectionViewCell
        cell.updateUI(news: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == dataSource.count - 1) && shouldRefresh {
            getData()
        }
    }
}



