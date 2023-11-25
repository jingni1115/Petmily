import UIKit
import SnapKit

class LocationViewController: UIViewController {
    let kakaoMapViewController = KakaoMapViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(kakaoMapViewController)
        view.addSubview(kakaoMapViewController.view)
        kakaoMapViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        kakaoMapViewController.didMove(toParent: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        kakaoMapViewController.addObservers()
        if kakaoMapViewController._auth {
            if kakaoMapViewController.mapController?.engineStarted == false {
                kakaoMapViewController.mapController?.startEngine()
            }

            if kakaoMapViewController.mapController?.rendering == false {
                kakaoMapViewController.mapController?.startRendering()
            }
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        kakaoMapViewController.containerDidResized(view.bounds.size)
    }

    // 인증 성공시 delegate 호출.
    func authenticationSucceeded() {
        kakaoMapViewController._auth = true
        kakaoMapViewController.mapController?.startEngine()
        kakaoMapViewController.mapController?.startRendering()
        kakaoMapViewController.addViews()
    }

    // 인증 실패시 호출.
    func authenticationFailed(_ errorCode: Int, desc: String) {
        print("error code: \(errorCode)")
        print("\(desc)")

        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            print("retry auth...")
            self.kakaoMapViewController.mapController?.authenticate()
        }
    }
}
