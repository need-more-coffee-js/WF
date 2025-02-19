//
//  ClanModel.swift
//  WFAPP
//
//  Created by Денис Ефименков on 19.02.2025.
//

import Foundation
// MARK: - ClanModelElement
struct ClanModelElement: Codable {
    let clan, clanLeader, members, points: String?
    let rank: String?

    enum CodingKeys: String, CodingKey {
        case clan
        case clanLeader = "clan_leader"
        case members, points, rank
    }
}

typealias ClanModel = [ClanModelElement]


// MARK: - ClanMembersModel
struct ClanMembersModel: Codable {
    let id, name: String?
    let members: [Member]?
}

// MARK: - Member
struct Member: Codable {
    let nickname, rankID, clanPoints: String?
    let clanRole: ClanRole?

    enum CodingKeys: String, CodingKey {
        case nickname
        case rankID = "rank_id"
        case clanPoints = "clan_points"
        case clanRole = "clan_role"
    }
}

enum ClanRole: String, Codable {
    case officer = "OFFICER"
    case regular = "REGULAR"
    case master = "MASTER"
}
