
import Foundation

private class BundleCalss { }

extension Bundle {
    static let module: Bundle = {
        return Bundle(for: BundleCalss.self)
    }()
}
