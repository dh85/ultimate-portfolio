//
//  ProjectsViewModelTests.swift
//  UltimatePortfolioTests
//
//  Created by David Hughes on 20/03/2021.
//

import CoreData
import XCTest
@testable import UltimatePortfolio

class ProjectsViewModelTests: XCTestCase {
    func testCorrectTitle() {
        let viewModel1 = ProjectsViewModel(dataController: DataController.preview, showClosedProjects: false)
        XCTAssertEqual(viewModel1.title, "Open Projects")

        let viewModel2 = ProjectsViewModel(dataController: DataController.preview, showClosedProjects: true)
        XCTAssertEqual(viewModel2.title, "Closed Projects")
    }

    func testOpenProjectsCorrectlyFiltered() {
        let viewModel = ProjectsViewModel(dataController: DataController.preview, showClosedProjects: false)

        XCTAssertEqual(viewModel.dataController.count(for: requestProjects(closed: false)), viewModel.projects.count)
    }

    func testClosedProjectsCorrectlyFiltered() {
        // Given
        let viewModel = ProjectsViewModel(dataController: DataController.preview, showClosedProjects: true)

        // Then
        XCTAssertEqual(viewModel.dataController.count(for: requestProjects(closed: true)), viewModel.projects.count)
    }

    func testAddProject() {
        let viewModel = ProjectsViewModel(dataController: DataController.preview, showClosedProjects: false)
        viewModel.addProject()
        XCTAssertEqual(viewModel.dataController.count(for: requestProjects(closed: false)), viewModel.projects.count)

        let viewModel1 = ProjectsViewModel(dataController: DataController.preview, showClosedProjects: true)
        let openProjectsCount = viewModel1.dataController.count(for: requestProjects(closed: false))
        viewModel1.addProject()
        XCTAssertEqual(viewModel1.dataController.count(for: requestProjects(closed: false)), openProjectsCount)
    }

    func testAddItem() {
        let viewModel = ProjectsViewModel(dataController: DataController.preview, showClosedProjects: false)

        let wasEmpty = viewModel.projects.isEmpty
        if wasEmpty {
            viewModel.addProject()
        }

        let precount = viewModel.projects[0].projectItems.count
        viewModel.addItem(to: viewModel.projects[0])

        XCTAssertEqual(viewModel.projects[0].projectItems.count, precount + 1)
    }

    private func requestProjects(closed: Bool) -> NSFetchRequest<Project> {
        let request: NSFetchRequest<Project> = NSFetchRequest(entityName: "Project")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)]
        request.predicate = NSPredicate(format: "closed = %d", closed)
        return request
    }
}
