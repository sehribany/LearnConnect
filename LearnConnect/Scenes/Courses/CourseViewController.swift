//
//  CourseViewController.swift
//  LearnConnect
//
//  Created by Şehriban Yıldırım on 22.11.2024.
//
import UIKit

class CourseViewController: BaseViewController<CourseViewModel> {
    
    //MARK: - Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RegistedCell.self, forCellReuseIdentifier: RegistedCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .appBackground
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        viewModel.fetchRegisteredCourses()
        NotificationCenter.default.addObserver(self, selector: #selector(courseAdded), name: NSNotification.Name("CourseAdded"), object: nil)
    }
    
    @objc private func courseAdded() {
        viewModel.fetchRegisteredCourses()
        tableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
//MARK: - UILayout
extension CourseViewController{
    private func addSubViews(){
        addTableView()
    }
    
    private func addTableView(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource
extension CourseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsAt(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RegistedCell.identifier, for: indexPath) as! RegistedCell
        let cellItem = viewModel.cellItemAt(indexPath: indexPath)
        cell.set(viewModel: cellItem)
        cell.delegate = self
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CourseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            let courseToDelete = self.viewModel.cellItemAt(indexPath: indexPath).course
            CourseManager.shared.removeCourse(courseToDelete)
            self.viewModel.fetchRegisteredCourses()
            tableView.delegate = self
            tableView.deleteRows(at: [indexPath], with: .automatic)
            NotificationCenter.default.post(name: NSNotification.Name("CourseDeleted"), object: courseToDelete)
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}

//MARK: - CourseCellDelegate
extension CourseViewController: RegistedCellDelegate{
    func didTapToCourseImageView(course: Course) {
        let detailViewModel = DetailViewModel(course: course)
        let detailVC = DetailViewController(viewModel: detailViewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
