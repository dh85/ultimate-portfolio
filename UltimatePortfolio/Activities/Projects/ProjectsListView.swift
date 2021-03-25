//
//  ProjectsListView.swift
//  UltimatePortfolio
//
//  Created by David Hughes on 20/03/2021.
//

import SwiftUI

struct ProjectsListView: View {
    @ObservedObject var viewModel: ProjectsViewModel

    var body: some View {
        List {
            ForEach(viewModel.projects) { project in
                Section(header: ProjectHeaderView(project: project)) {
                    ForEach(project.projectItems(using: viewModel.sortOrder)) { item in
                        ItemRowView(project: project, item: item)
                    }
                    .onDelete { offsets in
                        viewModel.delete(offsets, from: project)
                    }

                    if viewModel.showClosedProjects == false {
                        Button {
                            withAnimation {
                                viewModel.addItem(to: project)
                            }
                        } label: {
                            Label("Add New Item", systemImage: "plus")
                        }
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct ProjectsListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsListView(
            viewModel: ProjectsViewModel(
                dataController: DataController.preview,
                showClosedProjects: false
            )
        )
    }
}
