class Persona {

	var property celulasTotales
	var property temperatura
	const enfermedades = new Set()

	method enfermedadesNoCuradas() = enfermedades.filter({ enfermedad => enfermedad.celulasAmenazadas() > 0 })
	method contraer(enfermedad) = enfermedades.add(enfermedad)

}

class EnfermedadCelular {

	var property celulasAmenazadas

	method producirEfecto(persona)

	method esAgresiva(persona)

	method atenuar(cantidad) {
		if (celulasAmenazadas >= cantidad * 15) {
			celulasAmenazadas - cantidad * 15
		} else {
			0.max(celulasAmenazadas - cantidad * 15)
			throw new Exception(message="No se puede atenuar una enfermedad ya curada")
		}
	}

}

class EnfermedadInfecciosa inherits EnfermedadCelular {

	override method producirEfecto(persona) = persona.temperatura(persona.temperatura() + self.celulasAmenazadas() / 1000)

	method reproducirse() = self.celulasAmenazadas(self.celulasAmenazadas() * 2)

	override method esAgresiva(persona) = self.celulasAmenazadas() > persona.celulasTotales() / 10

}

class EnfermedadAutoinmune inherits EnfermedadCelular {

	var property diasAfectando = 0

	override method producirEfecto(persona) {
		persona.celulasTotales(persona.celulasTotales() - self.celulasAmenazadas())
		diasAfectando = diasAfectando + 1
	}

	override method esAgresiva(persona) = diasAfectando > 30

}

