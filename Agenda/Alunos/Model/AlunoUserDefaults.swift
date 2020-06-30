//
//  AlunoUserDefaults.swift
//  Agenda
//
//  Created by Luiz on 30/06/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit

class AlunoUserDefaults: NSObject {
    let preferencias = UserDefaults.standard
    
    func salvaVersao(_ versao: String) {
        preferencias.set(versao, forKey: "ultima-versao")
    }
    
    func recuperaUltimaVersao() -> String? {
        let versao = preferencias.object(forKey: "ultima-versao") as? String
        return versao
    }
}
