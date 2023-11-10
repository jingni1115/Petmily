import UIKit
import SnapKit

class LocationViewController: UIViewController {
    
    // MARK: - Propeties
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "LocationView"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
    }
    
    // MARK: - UI Setting
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(textLabel)
    }
    
    func configureUI() {
        textLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }

}
