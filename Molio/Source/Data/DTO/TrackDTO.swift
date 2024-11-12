struct TrackDTO: Decodable {
    let externalIDs: ExternalIDsDTO
    
    enum CodingKeys: String, CodingKey {
        case externalIDs = "external_ids"
    }
}
