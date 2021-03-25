//
//  ProjectsViewModel.swift
//  UltimatePortfolio
//
//  Created by David Hughes on 19/03/2021.
//

import CoreData
import Foundation

class ProjectsViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    let dataController: DataController

    var sortOrder = Item.SortOrder.optimised

    let showClosedProjects: Bool

    private let projectsController: NSFetchedResultsController<Project>
    @Published var projects = [Project]()

    var title: String {
        showClosedProjects ?
            NSLocalizedString("Closed Projects", comment: "") :
            NSLocalizedString("Open Projects", comment: "")
    }

    init(dataController: DataController, showClosedProjects: Bool) {
        self.dataController = dataController
        self.showClosedProjects = showClosedProjects

        let request: NSFetchRequest<Project> = Project.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)]
        request.predicate = NSPredicate(format: "closed = %d", showClosedProjects)

        projectsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: dataController.container.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )

        super.init()
        projectsController.delegate = self

        do {
            try projectsController.performFetch()
            projects = projectsController.fetchedObjects ?? []
        } catch {
            print("Failed to fetch our projects!")
        }
    }

    func addProject() {
        if showClosedProjects == false {
            let project = Project(context: dataController.container.viewContext)
            project.closed = false
            project.creationDate = Date()
            dataController.save()
        }
    }

    func addItem(to project: Project) {
        if showClosedProjects == false {
            let item = Item(context: dataController.container.viewContext)
            item.project = project
            item.creationDate = Date()
            dataController.save()
        }
    }

    func delete(_ offsets: IndexSet, from project: Project) {
        let allItems = project.projectItems(using: sortOrder)

        for offset in offsets {
            let item = allItems[offset]
            dataController.delete(item)
        }

        dataController.save()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let newProjects = controller.fetchedObjects as? [Project] {
            projects = newProjects
        }
    }
}
