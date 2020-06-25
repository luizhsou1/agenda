//
//  Repositorio.swift
//  Agenda
//
//  Created by Luiz on 25/06/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit

class Repositorio: NSObject {
    func salvaAluno(aluno: Dictionary<String, String>) {
        AlunoAPI().salvaAlunosNoServidor(parametros: [aluno])
        AlunoDAO().salvaAlunoLocal(dicionarioDeAluno: aluno)
    }
}
