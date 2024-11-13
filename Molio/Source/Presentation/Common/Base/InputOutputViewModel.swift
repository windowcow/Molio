protocol InputOutputViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(from input: Input) -> Output
}
