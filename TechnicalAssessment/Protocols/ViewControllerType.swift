import UIKit

protocol ViewControllerType: UIViewController {
    associatedtype ServiceType

    var viewModel: ServiceType { get }

    init(viewModel: ServiceType)
}
