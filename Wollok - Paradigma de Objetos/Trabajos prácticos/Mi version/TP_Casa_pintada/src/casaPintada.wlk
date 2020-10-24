class Pintor {

	method costoManoDeObra(metrosCuadrados)

	method costo(metrosCuadrado, porMenorOPorMayor)

}

object raul inherits Pintor {

	override method costoManoDeObra(metrosCuadrado) = 70 * metrosCuadrado

	override method costo(metrosCuadrados, porMenorOPorMayor) = self.costoManoDeObra(metrosCuadrados) + pintureria.latasNecesarias(metrosCuadrados, porMenorOPorMayor)

}

object carla inherits Pintor {

	override method costoManoDeObra(metrosCuadrados) = if (metrosCuadrados <= 25) 45 * metrosCuadrados * 2 else 45 * metrosCuadrados * 1.5

	override method costo(metrosCuadrados, porMenorOPorMayor) = self.costoManoDeObra(metrosCuadrados)

}

object venancio inherits Pintor {

	override method costoManoDeObra(metrosCuadrado) = 43 * metrosCuadrado

	override method costo(metrosCuadrados, porMenorOPorMayor) = self.costoManoDeObra(metrosCuadrados) + pintureria.latasNecesarias(metrosCuadrados, porMenorOPorMayor) / 2

}

object pintureria {

	var property costoPorLataPorMenor = 500
	var property costoPorLataPorMayor = 12

	method latasNecesariasPorMenor(metrosCuadrado) = (metrosCuadrado / 50).roundUp()

	method latasNecesariasPorMayor(metrosCuadrado) = (metrosCuadrado / 2).roundUp()

	method latasNecesarias(metrosCuadrados, porMenorOPorMayor) { // 0 para pintura por menor, cualquier numero para pintura por mayor
		if (porMenorOPorMayor == 0) return self.latasNecesariasPorMenor(metrosCuadrados) else return self.latasNecesariasPorMayor(metrosCuadrados)
	}

}

object aldo {

	var property casa = casaChica
	var property ahorros

	method presupuesto() = self.ahorros() / 5
	method contratarPintor(pintor, porMenorOPorMayor) = ( self.presupuesto() > pintor.costo(casaChica.superficieTotal(), porMenorOPorMayor) )

 
	method ahorrar(montoAhorrado) { ahorros = ahorros + montoAhorrado }

}

object casaChica {

	const ambientes = #{ habitacionComun, cocina }

	method superficieTotal() = ambientes.map({ ambiente => ambiente.superficie() })

}

class Habitacion {

	var property superficie

}

object habitacionComun inherits Habitacion {

	override method superficie() = 20

}

object cocina inherits Habitacion {

	const property ancho = 1
	const property largo = 2
	const property alto = 3.5

	override method superficie() = (ancho + largo) * 2 * alto

}

