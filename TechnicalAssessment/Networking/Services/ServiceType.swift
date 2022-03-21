import Foundation
import Combine
import UIKit

protocol ServiceType {
    var client: APIClient { get }
    var requestBuilder: RequestBuilder { get }
}
