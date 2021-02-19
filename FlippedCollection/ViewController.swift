//
//  ViewController.swift
//  FlippedCollection
//
//  Created by Sergey Matveev on 19.02.2021.
//

import UIKit

private let cellIdentifier = "cell-identifier"

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout {

    private var model = [String]()
    private var messageCounter = 0

    private var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .green
        return collectionView
    }()

    private let buttonHeight: CGFloat = 44
    private let cellHeight: CGFloat = 44

    private var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yellow
        button.setTitle("Написать", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        return button
    }()

    @objc private func onClick() {
        messageCounter += 1
        model.insert("Тестовое сообщение номер " + String(messageCounter), at: 0)
        collectionView.insertItems(at: [IndexPath(item: 0, section: 0)])
    }

    override func viewWillLayoutSubviews() {
        super .viewWillLayoutSubviews()

        collectionView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - buttonHeight)
        button.frame = CGRect(x: 0, y: collectionView.frame.maxY, width: self.view.bounds.width, height: buttonHeight)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.transform = CGAffineTransform(scaleX: 1, y: -1)

        collectionView.delegate = self
        collectionView.dataSource = self

        self.view.addSubview(collectionView)
        self.view.addSubview(button)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: cellHeight)
    }
}

extension ViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.model.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        (cell as? CustomCell)?.setupView(title: model[indexPath.row])
        return cell
    }
}
