//
//  DiceModel.swift
//  LuckyDice
//
//  Created by Мирсаит Сабирзянов on 17.03.2024.
//

import Foundation

struct DiceModel: Codable, Hashable {
    var edge: Int
    var count: Int
    var result: [Int]
    var totalSum: Int
}
