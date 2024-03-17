//
//  ContentView.swift
//  LuckyDice
//
//  Created by Мирсаит Сабирзянов on 17.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section("Results:"){
                        Text("Total sum: \(viewModel.totalSum)")
                    }
                    Section{
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray)
                                .fill(.purple)
                                .frame(height: 300)
                            HStack {
                                ForEach((viewModel.result), id: \.self) { result in
                                    Text("\(result)")
                                        .font(.title3)
                                        .bold()
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                    }
                }
                Button {
                    viewModel.time = 2.0
                    viewModel.isActive.toggle()
                } label: {
                    Text("Roll the dice")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.white)
                        .padding(10)
                        .background(.purple)
                        .clipShape(.rect(cornerRadius: 10))
                }
            }
            .sensoryFeedback(.impact(flexibility: .rigid, intensity: 0.7), trigger: viewModel.time)

            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu( content: {
                        Picker(selection: $viewModel.edge, label: Text("Variants")) {
                            ForEach(viewModel.edges, id: \.self) { edge in
                                Text("\(edge)")
                            }
                        }
                    }, label: {
                        Image(systemName: "dice.fill")
                            .foregroundColor(Color.purple)
                    })
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Menu( content: {
                        Picker(selection: $viewModel.count, label: Text("Count")) {
                            ForEach((1...10), id: \.self) { count in
                                Text("Number of cubes: \(count)")
                            }
                        }
                    }, label: {
                        Image(systemName: "\(viewModel.count).square.fill")
                            .foregroundColor(Color.purple)
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                      HistoryView()
                    } label: {
                        Image(systemName: "list.bullet.clipboard.fill")
                            .foregroundColor(Color.purple)

                    }
                }
            }
            .onReceive(viewModel.timer) { t in
                guard viewModel.isActive else { return }
                if viewModel.time > 0 {
                    viewModel.time -= 0.1
                    viewModel.roll()
                } else {
                    viewModel.isActive = false
                    viewModel.calculateTotalSum()
                    viewModel.saveResult()
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
