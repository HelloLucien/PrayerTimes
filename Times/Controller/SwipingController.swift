//
//  SwipingController.swift
//  Times
//
//  Created by Lucien Hua on 02/02/2020.
//  Copyright © 2020 LucienHua. All rights reserved.
//

import UIKit
import Adhan

class SwippingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

	let cellId = "cellId"
	var prayers = [Prayer]()

	let pageControl: UIPageControl = {
		let pageControl = UIPageControl()
		pageControl.numberOfPages = 5
		pageControl.currentPageIndicatorTintColor = .systemGreen
		pageControl.pageIndicatorTintColor = .tertiaryLabel
		pageControl.translatesAutoresizingMaskIntoConstraints = false
		return pageControl
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		collectionView.backgroundColor = .systemBackground
		collectionView.isPagingEnabled = true
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)

		view.addSubview(pageControl)
		pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

		guard let prayerTimes = initPrayerTimes(latitude: 48.8409, longitude: 2.3518) else { return }

		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "HH:mm"

		prayers.append(Prayer(name: "Fajr", time: dateFormatter.string(from: prayerTimes.fajr)))
		prayers.append(Prayer(name: "Dhuhr", time: dateFormatter.string(from: prayerTimes.dhuhr)))
		prayers.append(Prayer(name: "Asr", time: dateFormatter.string(from: prayerTimes.asr)))
		prayers.append(Prayer(name: "Maghrib", time: dateFormatter.string(from: prayerTimes.maghrib)))
		prayers.append(Prayer(name: "Isha", time: dateFormatter.string(from: prayerTimes.isha)))

		guard let nextPrayer = prayerTimes.nextPrayer() else { return }
		let prayerTime = prayerTimes.time(for: nextPrayer)
		let times = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: prayerTime)

		// 1 - Ask for permission
		let center = UNUserNotificationCenter.current()

		// 2 - Create the notification content
		let content = UNMutableNotificationContent()
		content.title = "\(nextPrayer) - \(dateFormatter.string(from: prayerTime))"
		content.body = "⏰"
		content.sound = .default

		// 3 - Create the notification trigger
		let trigger = UNCalendarNotificationTrigger(dateMatching: times, repeats: true)

		// 4 - Create the request
		let uuidString = UUID().uuidString
		let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)

		// 5 - Register the request
		center.add(request) { (error) in
			guard error != nil else { return }
		}
	}

	func initPrayerTimes(latitude: Double, longitude: Double) -> PrayerTimes? {
		let coordinates = Coordinates(latitude: latitude, longitude: longitude)
		let date = Calendar.current.dateComponents([.year, .month, .day], from: Date())
		var params = CalculationMethod.muslimWorldLeague.params

		params.adjustments.maghrib = 4
		params.adjustments.isha = -5

		return PrayerTimes(coordinates: coordinates, date: date, calculationParameters: params)
	}
}
