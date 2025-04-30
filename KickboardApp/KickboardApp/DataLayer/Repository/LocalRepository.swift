//
//  LocalRepository.swift
//  KickboardApp
//
//  Created by 이수현 on 4/30/25.
//

import Foundation
import NMapsMap

final class LocalRepository: LocalRepositoryProtocol {
    private let service: NetworkServiceProtocol

    init(service: NetworkServiceProtocol) {
        self.service = service
    }

    func fetchLocalInfo(query: String) async throws -> [Local] {
        return try await service.fetchLocalInfo(query: query).items
            .compactMap { local -> Local? in
                guard let utmkX = Double(local.mapx),
                      let utmkY = Double(local.mapy)
                else {
                    return nil
                }
                let title = local.title
                    .replacingOccurrences(of: "<b>", with: "")
                    .replacingOccurrences(of: "</b>", with: "")

                let utmkCoord = NMGUtmk(x: utmkX, y: utmkY)
                let latlngCoord = utmkCoord.toLatLng()

                return Local(
                    title: title,
                    roadAddress: local.roadAddress,
                    latitude: latlngCoord.lat,
                    longitude: latlngCoord.lng
                )
            }
    }
}
