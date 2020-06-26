//
//  Filtro.swift
//  Agenda
//
//  Created by Alura Roxo on 06/03/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit

class Filtro: NSObject {
    
    func filtraAlunos(listaDeAlunos:Array<Aluno>, texto:String) -> Array<Aluno> {
        let alunosEncontrados = listaDeAlunos.filter { (aluno) -> Bool in
            if let nome = aluno.nome {
                return nome.contains(texto)
            }
            return false
        }
        return alunosEncontrados
    }

}
