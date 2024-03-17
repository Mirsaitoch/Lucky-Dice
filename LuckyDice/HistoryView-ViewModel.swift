//
//  HistoryView-ViewMOdel.swift
//  LuckyDice
//
//  Created by Мирсаит Сабирзянов on 17.03.2024.
//

import Foundation

extension HistoryView {
    @Observable class ViewModel {
        var savePath = URL.documentsDirectory.appending(path: "savedFiles")
        var requests = [DiceModel]()
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                requests = try JSONDecoder().decode([DiceModel].self, from: data)
            } catch {
                requests = []
            }
        }
    }
}
