//
//  ProspectEditView.swift
//  HotProspects
//
//  Created by Ahmet Büyükçelik on 27.08.2025.
//

import SwiftUI
import SwiftData

struct ProspectEditView: View {
    @Bindable var prospect: Prospect
    var body: some View {
            Form {
                Section("Name") {
                    TextField("Name", text: $prospect.name)
                    
                }
                Section("Email Address") {
                    TextField("Email Address", text: $prospect.emailAddress)
                }
            }
            .font(.headline)
            .navigationTitle("Edit Prospect")
    }
}

#Preview {
    ProspectEditView(prospect: Prospect(name: "Ahmet", emailAddress: "Ahmet@Gmail.com", isContacted: true))
        .modelContainer(for: Prospect.self)
}
