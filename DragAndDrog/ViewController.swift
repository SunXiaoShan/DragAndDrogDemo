//
//  ViewController.swift
//  DragAndDrog
//
//  Created by Phineas.Huang on 2020/4/22.
//  Copyright © 2020 Phineas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var cellDataList:[Any] = [1, 1, 1, 1, 1, 1, 1]
    let columnLayout = ColumnFlowLayout(
        cellsPerRow: 5,
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10,
        sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCollectionView()
    }

    func setupCollectionView() {
        self.collectionView.collectionViewLayout = columnLayout
        self.collectionView.dataSource = self
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DragDrogCollectionViewCell", for: indexPath) as! DragDrogCollectionViewCell
        cell.backgroundColor = UIColor.yellow
        return cell
    }
    
    
    
    
    
    

}


