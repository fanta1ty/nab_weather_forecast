import UIKit
import RxSwift
import RxCocoa
import SkeletonView

// swiftlint:disable cyclomatic_complexity
// swiftlint:disable file_length
// swiftlint:disable function_body_length
class MainViewController: BaseViewController<HomeViewModel> {
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mainTableView: UITableView!
    
    private var forecastList = [ForecastItemInfo]()
    
    override func makeUpViews() {
        super.makeUpViews()
        
        setupUI()
    }
    
    override func bindingData() {
        super.bindingData()
        
        viewModel.output.onForecastResponse
            .drive(onNext: { [weak self] data in
                guard let self = self else { return }
                
                self.forecastList = data.list
                self.mainTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? ForecastTableViewCell
        else { return ForecastTableViewCell() }
        
        let data = forecastList[indexPath.row]
        cell.loadData(data: data)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MainViewController {
    private func setupUI() {
        
        topConstraint.constant = NavigationBarManager.bottomConstraint
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: ForecastTableViewCell.reuseIdentifier)
        
        if let customNav = customNav as? NMainView {
            customNav.titleLb.text = L10n.Dashboard.title
            
            customNav.searchBar.updateBackgroundImage(withRadius: 4.0, corners: .allCorners, color: UIColor(hex: "#ECFAFD"))
            
            customNav.searchTextDidChange = { [weak self] searchStr in
                guard let self = self else { return }
                Log.d("Search: \(searchStr)")
                
                self.viewModel.input.startSearchForecast.onNext(searchStr)
            }
        }
    }
}
