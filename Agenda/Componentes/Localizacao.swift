//
//  Localizacao.swift
//  Agenda
//
//  Created by Alura on 11/12/17.
//  Copyright © 2017 Alura. All rights reserved.
//

import UIKit
import MapKit

class Localizacao: NSObject, MKMapViewDelegate {
    
    func localizaAlunoNoWaze(_ alunoSelecionado:Aluno) {
        if UIApplication.shared.canOpenURL(URL(string: "waze://")!) {
            guard let enderecoDoAluno = alunoSelecionado.endereco else { return }
            Localizacao().converteEnderecoEmCoordenadas(endereco: enderecoDoAluno, local: { (localizacaoEncontrada) in
                let latitude = String(describing: localizacaoEncontrada.location!.coordinate.latitude)
                let longitude = String(describing: localizacaoEncontrada.location!.coordinate.longitude)
                let url:String = "waze://?ll=\(latitude),\(longitude)&navigate=yes"
                UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
            })
        }
    }
    
    func converteEnderecoEmCoordenadas(endereco:String, local:@escaping(_ local:CLPlacemark) -> Void) {
        let conversor = CLGeocoder()
        conversor.geocodeAddressString(endereco) { (listaDeLocalizacoes, error) in
            if let localizacao = listaDeLocalizacoes?.first {
                local(localizacao)
            }
        }
    }
    
    func configuraPino(titulo:String, localizacao:CLPlacemark, cor:UIColor?, icone:UIImage?) -> Pino {
        let pino = Pino(coordenada: localizacao.location!.coordinate)
        pino.title = titulo
        pino.color = cor
        pino.icon = icone
        
        return pino
    }
    
    func configuraBotaoLocalizacaoAtual(mapa:MKMapView) -> MKUserTrackingButton {
        let botao = MKUserTrackingButton(mapView: mapa)
        botao.frame.origin.x = 10
        botao.frame.origin.y = 10
        
        return botao
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is Pino {
            let annotationView = annotation as! Pino
            var pinoView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationView.title!) as? MKMarkerAnnotationView
            pinoView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: annotationView.title!)
            
            pinoView?.annotation = annotationView
            pinoView?.glyphImage = annotationView.icon
            pinoView?.markerTintColor = annotationView.color
            
            return pinoView
        }
        return nil
    }

}
