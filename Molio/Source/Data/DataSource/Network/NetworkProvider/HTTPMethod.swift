/// HTTP Request Method
enum HTTPMethod: String {
    case get
    case post

    var value: String {
        rawValue.uppercased()
    }
}
