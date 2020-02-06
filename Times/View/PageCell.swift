//
//  PageCell.swift
//  Times
//
//  Created by Lucien Hua on 02/02/2020.
//  Copyright © 2020 LucienHua. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {

	var prayer: Prayer? {
		didSet {
			prayerLabel.text = prayer?.name
			timeLabel.text = prayer?.time
		}
	}

	private let prayerLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 60, weight: .bold)
		label.textAlignment = .center
		label.textColor = .systemGreen
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private let timeLabel: UILabel = {
		let label = UILabel()
		label.textColor = .tertiaryLabel
		label.font = .systemFont(ofSize: 30, weight: .medium)
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}

	fileprivate func setupViews() {
		addSubview(prayerLabel)
		prayerLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		prayerLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		prayerLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

		addSubview(timeLabel)
		timeLabel.topAnchor.constraint(equalTo: prayerLabel.bottomAnchor).isActive = true
		timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
