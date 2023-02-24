//
//  ContentView.swift
//  CheckSplit
//
//  Created by Anastasia Kotova on 20.02.23.
//

import SwiftUI

struct ContentView: View {
    @State private var sum = 0.0
    @State private var numberOfPeople = 2
    @State private var tipProcent = 10
    @FocusState private var isTyping: Bool
    private let rangeOfTips = [0, 5, 10, 15, 20, 25]
    private let backgroundColor: Color = Color(red: 126/255, green: 175/255, blue: 72/255)
    private let currencyFotmatter: FloatingPointFormatStyle<Double>.Currency = .currency(code:Locale.current.identifier)
    private var amountPerPerson:  Double  {
        let people = Double(numberOfPeople + 2)
        let chosenAmountOfTips = Double(tipProcent)
        let totalTips = chosenAmountOfTips * (sum / 100)
        let total = sum + totalTips
        return total / people
    }
    private var total:  Double  {
        let chosenAmountOfTips = Double(tipProcent)
        let totalTips = chosenAmountOfTips * (sum / 100)
        return sum + totalTips
    }
    
    private var totalTips:  Double  {
        let chosenAmountOfTips = Double(tipProcent)
        return chosenAmountOfTips * (sum / 100)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $sum, format:
                            .currency(code:Locale.current.identifier))
                    .keyboardType(.decimalPad)
                    .focused($isTyping)
                        
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<30) {
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("Enter your data")
                        .foregroundColor(.black)
                        .bold()
                }
                Section {
                    Picker("Tips", selection: $tipProcent) {
                        ForEach(rangeOfTips, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }header: {
                    Text("Choose amount of tips")
                        .foregroundColor(.black)
                        .bold()
                }
                
                Section {
                    Text("Per person:")
                        .bold()
                    Text(amountPerPerson, format: currencyFotmatter)
                    Text("Total:")
                        .bold()
                    Text(total, format: currencyFotmatter)
                    Text("Total amount of tips:")
                        .bold()
                    Text(totalTips, format: currencyFotmatter)
                        .foregroundColor((tipProcent == 0) ? .red : .black)
                }
            }
            .navigationTitle(Text("CheckSplit"))
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)
            .background(backgroundColor)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isTyping = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
