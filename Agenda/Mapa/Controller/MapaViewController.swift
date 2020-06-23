//
//  MapaViewController.swift
//  Agenda
//
//  Created by Luiz on 23/06/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit
import MapKit

class MapaViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var mapa: MKMapView!
    
    // MARK: - Variáveis
    var aluno: Aluno?
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = getTitulo()
        self.localizacaoInicial()
        self.localizarAluno()
    }
    
    // MARK: - Métodos
    func getTitulo() -> String {
        return "Localizar Alunos"
    }
    
    func localizacaoInicial() {
        Localizacao().converteEnderecoEmCoordenadas(endereco: "Parque do Sabiá - Uberlândia") { (localizacaoEncontrada) in
            let pino = self.configuraPino(titulo: "Parque do Sabiá", localizacao: localizacaoEncontrada)
            let regiao = MKCoordinateRegionMakeWithDistance(pino.coordinate, 10000, 10000)
            self.mapa.setRegion(regiao, animated: true)
            self.mapa.addAnnotation(pino)
        }
    }
    
    func localizarAluno() {
        if let aluno = aluno {
            Localizacao().converteEnderecoEmCoordenadas(endereco: aluno.endereco!) { (localizacaoEncontrada) in
                let pino = self.configuraPino(titulo: aluno.nome!, localizacao: localizacaoEncontrada)
                self.mapa.addAnnotation(pino)
            }
        }
    }
    
    func configuraPino(titulo: String, localizacao: CLPlacemark) -> MKPointAnnotation {
        let pino = MKPointAnnotation()
        pino.title = titulo
        pino.coordinate = localizacao.location!.coordinate
        
        return pino
    }
}
