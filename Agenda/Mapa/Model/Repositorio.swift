//
//  Repositorio.swift
//  Agenda
//
//  Created by Luiz on 25/06/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit

class Repositorio: NSObject {
    func recuperaAlunos(completion: @escaping (_ listaDeAlunos: Array<Aluno>) -> Void) {
        var alunos = AlunoDAO().recuperaAlunos()
        if alunos.count == 0 {
            AlunoAPI().recuperaAlunos() {
                // É uma closure, só será executada depois que obtiver resposta do servidor, é a completion do metodo na camada de API...
                alunos = AlunoDAO().recuperaAlunos()
                completion(alunos)
            }
        } else {
            completion(alunos)
        }
    }
    
    func salvaAluno(aluno: Dictionary<String, String>) {
        AlunoAPI().salvaAlunosNoServidor(parametros: [aluno])
        AlunoDAO().salvaAlunoLocal(dicionarioDeAluno: aluno)
    }
    
    func deletaAluno(aluno: Aluno) {
        guard let id = aluno.id else { return }
        AlunoAPI().deletaAluno(id: String(describing: id))
        AlunoDAO().deletaAluno(aluno: aluno)
    }
}
