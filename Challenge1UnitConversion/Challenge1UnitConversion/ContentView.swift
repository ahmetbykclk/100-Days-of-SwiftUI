//
//  ContentView.swift
//  Challenge1UnitConversion
//
//  Created by Ahmet Büyükçelik on 4.08.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedUnitInput = "Kilometer"
    @State private var selectedUnitOutput = "Mile"
    @State private var inputValue: Double = 0
    let units: [String] = ["Kilometer", "Meter", "Feet", "Yard", "Mile"]
    var convertedValue: Double {
        var inputToMeter = 0.0
        switch selectedUnitInput {
        case "Kilometer":
            inputToMeter = inputValue * 1000
        case "Meter":
            inputToMeter = inputValue
        case "Feet":
            inputToMeter = inputValue * 0.3048
        case "Yard":
            inputToMeter = inputValue * 0.9144
        case "Mile":
            inputToMeter = inputValue * 1609.34
        default:
            break
        }
        switch selectedUnitOutput {
        case "Kilometer":
            return inputToMeter / 1000
        case "Meter":
            return inputToMeter
        case "Feet":
            return inputToMeter / 0.3048
        case "Yard":
            return inputToMeter / 0.9144
        case "Mile":
            return inputToMeter / 1609.34
        default:
            return 0
        }
        
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("input unit") {
                    Picker("Unit Type", selection: $selectedUnitInput) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section("Output Unit") {
                    Picker("Unit Type", selection: $selectedUnitOutput) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section {
                    TextField("Enter value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                }
                Section("Converted value") {
                    Text(convertedValue, format: .number)
                }
            }
            .navigationTitle("Length Converter")
        }
    }
}

#Preview {
    ContentView()
}
