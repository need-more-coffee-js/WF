//
//  ClanViewModel.swift
//  WFAPP
//
//  Created by Денис Ефименков on 19.02.2025.
//

import Foundation

class ClanViewModel {
    private var clans: [ClanModelElement] = []
    
    // Загрузка данных из API
    func fetchClans(completion: @escaping () -> Void) {
        guard let url = URL(string: ApiManager.clanAPI) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching users: \(error)")
                return
            }

            if let data = data {
                do {
                    let decodedClans = try JSONDecoder().decode([ClanModelElement].self, from: data)
                    self.clans = decodedClans
                    completion()
                } catch {
                    print("Error decoding users: \(error)")
                }
            }
        }.resume()
    }
    
    // Количество пользователей
    func numberOfClans() -> Int {
        return clans.count
    }

    // Получить пользователя по индексу
    func clanAtIndex(_ index: Int) -> ClanModelElement {
        return clans[index]
    }

}
