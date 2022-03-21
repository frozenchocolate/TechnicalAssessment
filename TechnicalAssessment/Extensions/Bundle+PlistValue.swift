import Foundation

extension Bundle {
    static func infoPlistValue<T>(forKey key: String) -> T? {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? T else {
           return nil
        }
        return value
    }
}
