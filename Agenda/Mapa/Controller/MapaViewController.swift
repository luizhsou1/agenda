//
//  MapaViewController.swift
//  Agenda
//
//  Created by Luiz on 23/06/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit

class MapaViewController: UIViewController {
    
    // MARK: - Variáveis
    var aluno: Aluno?
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = getTitulo()
        print(aluno?.nome)
    }
    
    func getTitulo() -> String {
        return "Localizar Alunos"
    }

}
