//
//  ViewController.swift
//  Times
//
//  Created by Lucien Hua on 01/02/2020.
//  Copyright © 2020 LucienHua. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	let prayerLabel: UILabel = {
		let label = UILabel()
		label.text = "Fajr"
		label.font = .systemFont(ofSize: 50, weight: .bold)
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	let timeLabel: UILabel = {
		let label = UILabel()
		label.text = "06:32"
		label.font = .systemFont(ofSize: 22, weight: .medium)
		label.textColor = .secondaryLabel
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	let pageControl: UIPageControl = {
		let pageControl = UIPageControl()
		pageControl.currentPage = 0
		pageControl.numberOfPages = 5
		pageControl.currentPageIndicatorTintColor = .label
		pageControl.pageIndicatorTintColor = .secondaryLabel
		pageControl.translatesAutoresizingMaskIntoConstraints = false
		return pageControl
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		setupViews()
	}

	fileprivate func setupViews() {
		view.addSubview(prayerLabel)
		prayerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		prayerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		prayerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

		view.addSubview(timeLabel)
		timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		timeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		timeLabel.topAnchor.constraint(equalTo: prayerLabel.bottomAnchor, constant: 5).isActive = true

		view.addSubview(pageControl)
		pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
	}
}
