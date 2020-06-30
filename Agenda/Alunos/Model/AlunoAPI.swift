//
//  AlunoAPI.swift
//  Agenda
//
//  Created by Alura Roxo on 28/02/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import UIKit
import Alamofire

class AlunoAPI: NSObject {
    
    // MARK: - Atributos
    lazy var url:String = {
        guard let url = Configuracao().getUrlPadrao() else { return "" }
        
        return url
    }()
    
    // MARK: - GET
    
    func recuperaAlunos(completion:@escaping() -> Void) {
        Alamofire.request(url + "api/aluno", method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                if let resposta = response.result.value as? Dictionary<String, Any> {
                    guard let listaDeAlunos = resposta["alunos"] as? Array<Dictionary<String, Any>> else { return }
                    for dicionarioDeAluno in listaDeAlunos {
                        AlunoDAO().salvaAluno(dicionarioDeAluno: dicionarioDeAluno)
                    }
                    completion()
                }
                break
            case .failure:
                print(response.error!)
                completion()
                break
            }
        }
    }
    
    func recuperaUltimosAlunos(_ versao: String) {
        Alamofire.request(url + "api/aluno/diff", method: .get, headers: ["datahora":versao]).responseJSON{(response) in
            switch response.result {
            case .success:
                print("ULTIMOS ALUNOS")
                break
            case .failure:
                print("FALHA")
                break
            }
        }
    }
    
    // MARK: - PUT
    
    func salvaAlunosNoServidor(parametros:Array<Dictionary<String, String>>) {
        guard let urlPadrao = Configuracao().getUrlPadrao() else { return }
        
        guard let url = URL(string: urlPadrao + "api/aluno/lista") else { return }
        var requisicao = URLRequest(url: url)
        requisicao.httpMethod = "PUT"
        let json = try! JSONSerialization.data(withJSONObject: parametros, options: [])
        requisicao.httpBody = json
        requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
        Alamofire.request(requisicao)
    }
    
    // MARK: - DELETE
    
    func deletaAluno(id:String) {
        Alamofire.request(url + "api/aluno/\(id)", method: .delete).responseJSON { (resposta) in
            switch resposta.result {
            case .failure:
                print(resposta.result.error!)
                break
            default:
                break
            }
        }
    }

}








