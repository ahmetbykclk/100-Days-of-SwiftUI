//
//  ContentView.swift
//  iExpense
//
//  Created by Ahmet Büyükçelik on 8.08.2025.
//

import SwiftUI
import SwiftData

@Model
class ExpenseItem {
    var name: String
    var type: String
    var amount: Double
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}

struct ContentView: View {
    @Query var expenses: [ExpenseItem]
    @Environment(\.modelContext) var modelContext
    
    @State private var sortOrder = SortOrder.name
    @State private var filter: FilterOption = .all
    
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    var personalItems: [ExpenseItem] {
        let filtered = expenses.filter { $0.type == "Personal" }
        switch sortOrder {
        case .name:
            return filtered.sorted { $0.name < $1.name }
        case .amount:
            return filtered.sorted { $0.amount > $1.amount }
        }
    }
    
    var businessItems: [ExpenseItem] {
        let filtered = expenses.filter { $0.type == "Business" }
        switch sortOrder {
        case .name:
            return filtered.sorted { $0.name < $1.name }
        case .amount:
            return filtered.sorted { $0.amount > $1.amount }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                if filter != .personal {
                    Section("Business") {
                        ForEach(businessItems) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: currencyCode))
                                    .font(item.amount > 10 ? .headline : .subheadline)
                            }
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel("\(item.name), \(item.amount, format: .currency(code: currencyCode))")
                            .accessibilityHint(item.type)
                        }
                        .onDelete { offsets in
                            removeItems(at: offsets, in: businessItems)
                        }
                    }
                }
                
                if filter != .business {
                    Section("Personal") {
                        ForEach(personalItems) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    
                                    Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: currencyCode))
                                    .font(item.amount > 10 ? .headline : .subheadline)
                            }
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel("\(item.name), \(item.amount, format: .currency(code: currencyCode))")
                            .accessibilityHint(item.type)
                        }
                        .onDelete { offsets in
                            removeItems(at: offsets, in: personalItems)
                        }
                    }
                }
                
                
                
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddView(currencyCode: currencyCode)
                } label: {
                    Label("Add Expense", systemImage: "plus")
                }
                Menu {
                    ForEach(SortOrder.allCases, id: \.self) { order in
                        Button(order.rawValue) {
                            sortOrder = order
                        }
                    }
                } label: {
                    Label("Sort", systemImage: "arrow.up.arrow.down")
                }
                Menu {
                    Picker("Filter", selection: $filter) {
                        Text("All").tag(FilterOption.all)
                        Text("Personal").tag(FilterOption.personal)
                        Text("Business").tag(FilterOption.business)
                    }
                } label: {
                    Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet, in categoryItems: [ExpenseItem]) {
        for offset in offsets {
            modelContext.delete(categoryItems[offset])
        }
    }
    
    enum SortOrder: String, CaseIterable {
        case name = "Name"
        case amount = "Amount"
    }
    
    enum FilterOption: String, CaseIterable {
        case all = "All"
        case personal = "Personal"
        case business = "Business"
    }
}

#Preview {
    ContentView()
}
