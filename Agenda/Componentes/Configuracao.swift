//
//  Configuracao.swift
//  Agenda
//
//  Created by Luiz on 26/06/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit

class Configuracao: NSObject {
    func getUrlPadrao() -> String? {
        guard let caminhoParaPlist = Bundle.main.path(forResource: "Info", ofType: "plist") else { return nil }
        guard let dicionario = NSDictionary(contentsOfFile: caminhoParaPlist) else { return nil }
        guard let urlPadrao = dicionario["UrlPadrao"] as? String else { return nil }
        
        return urlPadrao
    }
}
