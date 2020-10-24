object rolando {
	const valorBaseDeHechiceria = 3 
	var property hechizoPreferido
	
	var property valorBaseDeLucha = 1
	const artefactos = new Set()
	
	method nivelDeHechiceria() = (valorBaseDeHechiceria * hechizoPreferido.poder()) + fuerzaOscura.valor()
	method esPoderoso() = hechizoPreferido.esPoderoso() 
	
	method agregarArtefacto(artefacto) = artefactos.add(artefacto)
	method quitarArtefacto(artefacto) = artefactos.remove(artefacto)
	method vaciarArtefactos() = artefactos.clear()
	method valorDeLucha() = valorBaseDeLucha + artefactos.map({ artefacto => artefacto.unidadesDeLucha() }).sum()
	method masHabilidadDeLucha() = self.valorDeLucha() > self.nivelDeHechiceria()
	
	method estaCargado() = artefactos.size() >= 5
}
//1. Hechiceria
object espectroMalefico {
	var property nombreDeHechizo = "Espectro Malefico"
	
	method poder() = nombreDeHechizo.size()
	method esPoderoso() = self.poder() > 15
}
object hechizoBasico {
	method poder() = 10
	method esPoderoso() = false
}
object fuerzaOscura {
	var property valor = 5
	
	method eclipse() { valor = valor * 2 }
}
//2. Lucha
object espadaDelDestino { method unidadesDeLucha() = 3}
object collarDivino { 
	var property cantidadDePerlas
	method unidadesDeLucha() = cantidadDePerlas
}
object mascaraOscura { method unidadesDeLucha() = 4.max(fuerzaOscura.valor() / 2) }
//3. Lucha y Hechiceria avanzada
object armadura {
	var property refuerzo
	method unidadesDeLucha() =  2 + refuerzo.poder()
}
object cotaDeMalla {
	method poder() = 1
}
object bendicion {
	//method poder() = persona.nivelDeHechiceria()
}
object sinRefuerzo {
	method poder() = 0
}


object espejo {
	method unidadesDeLucha() {
		//artefactos.max( {artefacto => artefacto.unidadesDeLucha()} )
	}
}
class LibroDeHechizos {
	const hechizos = new Set()
	
	method poder() = hechizos.filter({hechizo => hechizo.esPoderoso() }).map({ hechizo => hechizo.poder() }).sum()
	method esPoderoso() = hechizos.any({ hechizo => hechizo.esPoderoso() })
	method agregarHechizo(hechizo) = hechizos.add(hechizo)
	method quitarHechizo(hechizo) = hechizos.add(hechizo)
	
}

