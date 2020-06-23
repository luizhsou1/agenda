//
//  Localizacao.swift
//  Agenda
//
//  Created by Luiz on 23/06/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit
import CoreLocation

class Localizacao: NSObject {
    func converteEnderecoEmCoordenadas(endereco: String, local: @escaping(_ local: CLPlacemark) -> Void) {
        let conversor = CLGeocoder()
        conversor.geocodeAddressString(endereco, completionHandler: { (listaDeLocalizacoes, error) in
            if let localizacao = listaDeLocalizacoes?.first {
                local(localizacao)
            }
        })
    }
}
