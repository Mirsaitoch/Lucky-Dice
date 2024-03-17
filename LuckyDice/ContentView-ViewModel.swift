//
//  ContentView-ViewModel.swift
//  LuckyDice
//
//  Created by Мирсаит Сабирзянов on 17.03.2024.
//

import Foundation
import SwiftUI

extension ContentView {
    @Observable class ViewModel{
        
        var edges = [2, 3, 4, 6, 8, 10, 12, 15, 16]
        var count = 1
        var edge = 4
        var result = [Int]()
        var time = 2.0
        var isActive = false
        var totalSum = 0
        var requests = [DiceModel]()
        
        var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

        var savePath = URL.documentsDirectory.appending(path: "savedFiles")
        
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                requests = try JSONDecoder().decode([DiceModel].self, from: data)
            } catch {
                requests = []
            }
        }
        
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        func roll() {
            result.removeAll()
            for _ in 1...count {
                result.append(Int.random(in: 1...edge))
            }
        }
        
        func calculateTotalSum() {
            totalSum = result.reduce(0, +)
        }
        
        func generateGridColumns(forWidth width: CGFloat) -> [GridItem] {
                let numberOfColumns = width > 600 ? 4 : 2 
                return Array(repeating: GridItem(.flexible(), spacing: 20), count: numberOfColumns)
        }
        
        func saveResult() {
            requests.append(DiceModel(edge: edge, count: count, result: result, totalSum: totalSum))
            do {
                let data = try JSONEncoder().encode(requests)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("error writing data")
            }
        }
    }
}
