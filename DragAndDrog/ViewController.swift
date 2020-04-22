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

    var cellDataList:[Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
    static let columnCount = 5
    let columnLayout = ColumnFlowLayout(
        cellsPerRow: columnCount,
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
        self.collectionView.dragInteractionEnabled = true
        self.collectionView.dragDelegate = self
        self.collectionView.dropDelegate = self
    }

    func updateDataIndex(from fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        let fromPosition = fromIndexPath.item
        let toPosition = toIndexPath.item
        let selected = cellDataList[fromPosition] as Int
        DispatchQueue.main.async {[weak self] in
            self?.cellDataList.remove(at: fromPosition)
            self?.cellDataList.insert(selected, at: toPosition)
            self?.collectionView.reloadData()
            UIView.performWithoutAnimation {
                self?.collectionView.reloadSections(IndexSet(integersIn: 0...0))
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellDataList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DragDrogCollectionViewCell", for: indexPath) as! DragDrogCollectionViewCell
        cell.backgroundColor = UIColor.yellow
        cell.label.text = String(cellDataList[indexPath.section * ViewController.columnCount +  indexPath.row])
        return cell
    }
}

extension ViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let attributedString = String(indexPath.item)
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: attributedString as NSItemProviderWriting))
        dragItem.localObject = attributedString
        return [dragItem]
    }
}

extension ViewController: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        if (collectionView.hasActiveDrag) {
            if let destinationIndexPath = coordinator.destinationIndexPath {
                updateDataIndex(from: coordinator.items.first!.sourceIndexPath!, to: destinationIndexPath)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        dropSessionDidUpdate session: UIDropSession,
                        withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
}


