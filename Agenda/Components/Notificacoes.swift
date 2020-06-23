//
//  Notificacoes.swift
//  Agenda
//
//  Created by Luiz on 23/06/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit

class Notificacoes: NSObject {
    
    func exibeNotificacaoDeMediaDosAlunos(dicionarioDeMedia: Dictionary<String, Any>) -> UIAlertController? {
        if let media = dicionarioDeMedia["media"] {
            let alerta = UIAlertController(title: "Atenção", message: "a média geral dos aluno é: \(media)", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
            alerta.addAction(ok)
            
            return alerta
        }
        return nil
    }
    
}
