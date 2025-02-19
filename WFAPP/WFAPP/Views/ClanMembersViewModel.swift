//
//  ClanMembersViewModel.swift
//  WFAPP
//
//  Created by Денис Ефименков on 19.02.2025.
//

import Foundation

class ClanMembersViewModel{
    private var members: [Member] = []
    
    func fetchMember(completion: @escaping () -> Void){
        guard let url = URL(string: ApiManager.clanMembersApi) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching users: \(error)")
                return
            }

            if let data = data {
                do {
                    let decodedClansMember = try JSONDecoder().decode([Member].self, from: data)
                    self.members = decodedClansMember
                    completion()
                } catch {
                    print("Error decoding users: \(error)")
                }
            }
        }.resume()
    }
    
    func numberOfMembers() -> Int {
        return members.count
    }

    // Получить пользователя по индексу
    func memberAtIndex(_ index: Int) -> Member {
        return members[index]
    }
}
