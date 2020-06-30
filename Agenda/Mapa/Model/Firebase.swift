//
//  Firebase.swift
//  Agenda
//
//  Created by Luiz on 26/06/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class Firebase: NSObject {
    
    enum StatusDoAluno: Int {
        case ativo // 0
        case inativo // 1
    }
    
    func enviaTokenParaServidor(token: String) {
        guard let url = Configuracao().getUrlPadrao() else { return }
        
        Alamofire.request(url + "api/firebase/dispositivo", method: .post, headers: ["token":token]).responseData { (response) in }
    }
    
    func serializaMensagem(mensagem: MessagingRemoteMessage) {
        guard let respostaDoFirebase = mensagem.appData["alunoSync"] as? String else { return }
        guard let data = respostaDoFirebase.data(using: .utf8) else { return }
        
        do {
            guard let mensagem = try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any> else { return }
            guard let listaDeAlunos = mensagem["alunos"] as? Array<Dictionary<String, Any>> else { return }
            sincronizaAlunos(alunos: listaDeAlunos)
            NotificationCenter.default.post(name: NSNotification.Name("atualizaAlunos"), object: nil)
        } catch {
            print(error.localizedDescription)
        }        
    }
    
    func sincronizaAlunos(alunos: Array<[String: Any]>) {
        
        for aluno in alunos {
            guard let status = aluno["desativado"] as? Int else { return }
            if status == StatusDoAluno.ativo.rawValue {
                AlunoDAO().salvaAluno(dicionarioDeAluno: aluno)
            } else {
                guard let idDoAluno = aluno["id"] as? String else { return }
                guard let aluno = AlunoDAO().recuperaAlunos().filter({ $0.id == UUID(uuidString: idDoAluno) }).first else { return }
                AlunoDAO().deletaAluno(aluno: aluno)
            }
        }
    }
}
