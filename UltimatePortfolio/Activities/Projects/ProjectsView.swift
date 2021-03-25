//
//  ProjectsView.swift
//  UltimatePortfolio
//
//  Created by David Hughes on 16/03/2021.
//

import SwiftUI

struct ProjectsView: View {
    static let openTag: String? = "Open"
    static let closedTag: String? = "Closed"

    @StateObject var viewModel: ProjectsViewModel
    @State private var showingSortOrder = false

    init(dataController: DataController, showClosedProjects: Bool) {
        let viewModel = ProjectsViewModel(dataController: dataController, showClosedProjects: showClosedProjects)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            Group {
                if viewModel.projects.isEmpty {
                    Text("There's nothing here right now")
                        .foregroundColor(.secondary)
                } else {
                    ProjectsListView(viewModel: viewModel)
                }
            }
            .navigationTitle(viewModel.title)
            .toolbar {
                addProjectToolbarItem
                sortOrderToolbarItem
            }
            .actionSheet(isPresented: $showingSortOrder) {
                ActionSheet(title: Text("Sort items"), message: nil, buttons: [
                    .default(Text("Optimized")) { viewModel.sortOrder = .optimised },
                    .default(Text("Creation Date")) { viewModel.sortOrder = .creationDate },
                    .default(Text("Title")) { viewModel.sortOrder = .title }
                ])
            }

            SelectSomethingView()
        }
    }

    var addProjectToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            if viewModel.showClosedProjects == false {
                Button {
                    withAnimation {
                        viewModel.addProject()
                    }
                } label: {
                    // In iOS 14.3 VoiceOver has a glitch that reads the label
                    // "Add Project" as "Add" no matter what accessibility label
                    // we give this button when using a label. As a result, when
                    // VoiceOver is running we use a text view for the button instead,
                    // forcing a correct reading without losing the original layout.
                    if UIAccessibility.isVoiceOverRunning {
                        Text("Add Project")
                    } else {
                        Label("Add Project", systemImage: "plus")
                    }
                }
            }
        }
    }

    var sortOrderToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                showingSortOrder.toggle()
            } label: {
                if UIAccessibility.isVoiceOverRunning {
                    Text("Sort")
                } else {
                    Label("Sort", systemImage: "arrow.up.arrow.down")
                }
            }
        }
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView(dataController: DataController.preview, showClosedProjects: false)
    }
}
