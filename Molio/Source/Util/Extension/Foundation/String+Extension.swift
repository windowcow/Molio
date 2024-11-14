extension String {
    var toBase64: String? {
        self.data(using: .utf8)?.base64EncodedString()
    }
}
