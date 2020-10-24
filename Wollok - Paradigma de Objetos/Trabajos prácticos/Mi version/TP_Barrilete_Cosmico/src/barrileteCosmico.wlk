class Destino {
	const property nombre
	const property equipajeImprescindible = new Set()
	var property precio
	
	method agregarElementoAEquipaje(elemento) = equipajeImprescindible.add(elemento)
	method esDestacado() = precio > 2000
	method esPeligroso() = equipajeImprescindible.any({ elemento => elemento == "Vacuna gripal" }) || equipajeImprescindible.any({ elemento => elemento == "Vacuna B" }) 
}
object barrileteCosmico {
	const property cartaDeDestinos = new Set()

	method agregarDestino(destino) = cartaDeDestinos.add(destino)
	method destinosMasImportantes() = cartaDeDestinos.filter({ destino => destino.esDestacado() })
	method aplicarDescuentoATodos(descuento) = cartaDeDestinos.forEach({ destino => destino.aplicarDescuento(descuento, destino) })
	method aplicarDescuento(descuento, destino) {
		destino.precio(destino.precio() - destino.precio() / 100 * descuento)
		destino.agregarElementoAEquipaje("Certificado de descuento")
	}
	method esEmpresaExtrema() = cartaDeDestinos.any({ destino => destino.esPeligroso() })
}
class Usuario {
	var property nombreDeUsuario
	const property lugaresVisitados = new Set()
	var property fondosEnCuenta
	const seguidos = new Set()
	
	method volarADestino(destino) {
		if(fondosEnCuenta < destino.precio())
			throw new Exception(message = "No tiene los fondos suficientes en su cuenta para realizar este viaje")
			
		self.agregarLugarVisitado(destino)
		fondosEnCuenta = fondosEnCuenta - destino.precio()
	}
	method agregarLugarVisitado(lugar) = lugaresVisitados.add(lugar)
	method kilometros() = lugaresVisitados.map({ destino => destino.precio() }).sum() / 10
	method seguirUsuario(usuario){
		self.agregarSeguidos(usuario)
		usuario.agregarSeguidos(self)
	}
	method agregarSeguidos(usuario) = seguidos.add(usuario)
}