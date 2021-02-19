//
//  CustomCell.swift
//  FlippedCollection
//
//  Created by Sergey Matveev on 19.02.2021.
//

import Foundation
import UIKit

class CustomCell: UICollectionViewCell {

    private var title: UILabel = {
        let title = UILabel()
        return title
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setupView() {
        self.contentView.addSubview(title)
        self.backgroundColor = .blue
        self.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
    }

    func setupView(title: String) {
        self.title.text = title
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        title.frame = self.contentView.bounds
    }
}
