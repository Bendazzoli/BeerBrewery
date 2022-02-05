//
//  Cervejaria.swift
//  BeerBrewery
//
//  Created by Paulo Henrique Bendazzoli on 05/02/22.
//

import UIKit

class Cervejaria {
    
    var imagem: UIImage!
    var nome: String!
    var avaliacao: Double!
    var tipo: String!
    var distancia: Double!
    
    
    init(imagem: UIImage, nome: String, avaliacao: Double, tipo: String, distancia: Double) {
        self.imagem = imagem
        self.nome = nome
        self.avaliacao = avaliacao
        self.tipo = tipo
        self.distancia = distancia
    }
}
