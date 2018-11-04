import UIKit

class ViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    @IBOutlet var scrollView: UIScrollView!

    @IBOutlet var textView: UITextView!
    @IBOutlet var collapseContainer: UIView!
    @IBOutlet var expandButton: UIButton!

    @IBOutlet var quantityLabels: [UILabel]!
    @IBOutlet var priceLabels: [UILabel]!

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentInsetAdjustmentBehavior = .never

        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        navigationItem.title = "Auto Layout Maniacs"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)

        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0

        zip(quantityLabels, priceLabels).forEach {
            $0.0.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: .regular)
            $0.1.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: .regular)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        scrollView.contentInset.bottom = view.safeAreaInsets.bottom
        scrollView.scrollIndicatorInsets = view.safeAreaInsets
        if let navigationBar = navigationController?.navigationBar {
            scrollView.scrollIndicatorInsets.top = navigationBar.frame.origin.y
        }
    }

    @IBAction func expandButtonTapped(_ sender: Any) {
        collapseContainer.isHidden.toggle()

        UIView.performWithoutAnimation {
            self.expandButton.setTitle(collapseContainer.isHidden ? "Collapse" : "Read more...", for: .normal)
            self.expandButton.layoutIfNeeded()
        }

        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
            self.textView.superview?.layoutIfNeeded()
        })
    }

    @IBAction func segmemtedControlValueChanged(_ sender: UISegmentedControl) {
        for (i, quantityLabel) in quantityLabels.enumerated() {
            quantityLabel.text = quantityValues[sender.selectedSegmentIndex][i]
        }
        for (i, priceLabel) in priceLabels.enumerated() {
            priceLabel.text = priceValues[sender.selectedSegmentIndex][i]
        }
    }
}

class NavigationController: UINavigationController {
    override var childForStatusBarStyle: UIViewController? { return viewControllers.first }
}
