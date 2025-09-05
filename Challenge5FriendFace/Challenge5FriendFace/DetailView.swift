//
//  DetailView.swift
//  Challenge5FriendFace
//
//  Created by Ahmet Büyükçelik on 22.08.2025.
//

import SwiftUI

struct DetailView: View {
    let user: User
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header Section
                headerSection
                    .padding(.bottom, 30)
                
                // Content Sections
                VStack(spacing: 24) {
                    profileSection
                    contactSection
                    aboutSection
                    friendsSection
                    tagsSection
                    registeredSection
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(user.name)
                    .font(.headline)
                    .fontWeight(.semibold)
            }
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(spacing: 16) {
            // Avatar Placeholder
            Circle()
                .fill(LinearGradient(
                    colors: [.blue.opacity(0.8), .purple.opacity(0.8)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 80, height: 80)
                .overlay(
                    Text(String(user.name.prefix(1)))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                )
            
            VStack(spacing: 4) {
                Text(user.name)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(user.company)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 8) {
                    Circle()
                        .fill(user.isActive ? Color.green : Color.red)
                        .frame(width: 8, height: 8)
                    
                    Text(user.isActive ? "Active" : "Inactive")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(user.isActive ? .green : .red)
                }
            }
        }
        .padding(.vertical, 30)
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
    }
    
    // MARK: - Profile Section
    private var profileSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader("Profile", icon: "person.circle.fill")
            
            VStack(spacing: 12) {
                infoRow(title: "Age", value: "\(user.age) years old")
                infoRow(title: "Company", value: user.company)
                infoRow(title: "Status", value: user.isActive ? "Active" : "Inactive", 
                       valueColor: user.isActive ? .green : .red)
            }
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
    
    // MARK: - Contact Section
    private var contactSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader("Contact", icon: "envelope.circle.fill")
            
            VStack(spacing: 12) {
                infoRow(title: "Email", value: user.email)
                infoRow(title: "Address", value: user.address)
            }
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
    
    // MARK: - About Section
    private var aboutSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader("About", icon: "text.quote")
            
            Text(user.about)
                .font(.body)
                .foregroundColor(.primary)
                .lineSpacing(4)
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
    
    // MARK: - Friends Section
    private var friendsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader("Friends (\(user.friends.count))", icon: "person.2.circle.fill")
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                ForEach(user.friends, id: \.id) { friend in
                    HStack {
                        Circle()
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: 32, height: 32)
                            .overlay(
                                Text(String(friend.name.prefix(1)))
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.blue)
                            )
                        
                        Text(friend.name)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .lineLimit(1)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
            }
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
    
    // MARK: - Tags Section
    private var tagsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader("Tags", icon: "tag.circle.fill")
            
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 80))
            ], spacing: 8) {
                ForEach(user.tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .fontWeight(.medium)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            LinearGradient(
                                colors: [.blue.opacity(0.1), .purple.opacity(0.1)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .foregroundColor(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                        )
                }
            }
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
    
    // MARK: - Registered Section
    private var registeredSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader("Registered", icon: "calendar.circle.fill")
            
            HStack {
                Image(systemName: "clock")
                    .foregroundColor(.blue)
                    .font(.subheadline)
                
                Text(user.formattedDate)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(8)
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
    
    // MARK: - Helper Views
    private func sectionHeader(_ title: String, icon: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .font(.title3)
            
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
            
            Spacer()
        }
    }
    
    private func infoRow(title: String, value: String, valueColor: Color = .primary) -> some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .frame(width: 80, alignment: .leading)
            
            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(valueColor)
            
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(user: User(
            id: "50a48fa3-2c0f-4397-ac50-64da464f9954",
            isActive: true,
            name: "Sarah Johnson",
            age: 28,
            company: "TechCorp",
            email: "sarah.johnson@techcorp.com",
            address: "123 Innovation Street, Silicon Valley, California, 94025",
            about: "Passionate software engineer with 5+ years of experience in iOS development. Love creating beautiful and intuitive user experiences. When not coding, you can find me hiking in the mountains or reading sci-fi novels. Always excited to learn new technologies and collaborate with amazing teams.",
            registered: Calendar.current.date(byAdding: .year, value: -2, to: Date()) ?? Date(),
            tags: ["iOS", "SwiftUI", "Mobile", "Design", "Innovation", "Leadership"],
            friends: [
                Friend(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0", name: "Michael Chen"),
                Friend(id: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf6", name: "Emily Rodriguez"),
                Friend(id: "be5918a3-8dc2-4f77-947c-7d02f69a58fe", name: "David Kim"),
                Friend(id: "f2f86852-8f2d-46d3-9de5-5bed1af9e4d6", name: "Lisa Thompson"),
                Friend(id: "6ba32d1b-8f2d-46d3-9de5-5bed1af9e4d6", name: "Alex Martinez"),
                Friend(id: "7cb43d2c-9g3e-57e4-0ef6-6cfe2bf0f5e7", name: "Rachel Green")
            ]
        ))
    }
}
