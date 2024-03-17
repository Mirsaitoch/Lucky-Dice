//
//  HistoryView.swift
//  LuckyDice
//
//  Created by Мирсаит Сабирзянов on 17.03.2024.
//

import SwiftUI

struct HistoryView: View {
    
    private var viewModel = ViewModel()
    var body: some View {
        List {
            ForEach(viewModel.requests, id: \.self) { request in
                HStack{
                    VStack(alignment: .leading){
                        Text("Total sum: \(request.totalSum)")
                        Text("Edges: \(request.edge)")
                        Text("Count of dices: \(request.count)")
                    }
                    Text(request.result.map { String($0) }.joined(separator: ", "))
                        .bold()
                }
            }
            
        }
    }
}

#Preview {
    HistoryView()
}
