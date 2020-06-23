//
//  MenuOpcoesAluno.swift
//  Agenda
//
//  Created by Luiz on 23/06/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit

enum OpcoesDoMenu {
    case sms
    case ligacao
    case waze
}

class MenuOpcoesAluno: NSObject {
    
    func configuraMenuDeOpcoesDoAluno(completion: @escaping(_ opcao: OpcoesDoMenu) -> Void) -> UIAlertController {
        let menu = UIAlertController(title: "Atenção", message: "escolha uma das opções abaixo", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let sms = UIAlertAction(title: "enviar SMS", style: .default) { (acao) in
            completion(.sms)
        }
        menu.addAction(sms)
        
        let ligacao = UIAlertAction(title: "ligar", style: .default) { (acao) in
            completion(.ligacao)
        }
        menu.addAction(ligacao)
        
        let waze = UIAlertAction(title: "localizar no waze", style: .default) { (acao) in
            completion(.waze)
        }
        menu.addAction(waze)
        
        let cancelar = UIAlertAction(title: "cancelar", style: .cancel, handler: nil)
        menu.addAction(cancelar)
        
        return menu
    }
    
}
