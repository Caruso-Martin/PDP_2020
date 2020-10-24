object pepe {

	var property categoria
	var property diasAusente
	var property bonoPorResultados

	method sueldo() = self.categoria().neto() + self.bonoPorPresentismo() + self.bonoPorResultados().valor(self.categoria())
	
	// Bono por presentismo
	method bonoPorPresentismo() {
		if(diasAusente == 0) return 100
		else if(diasAusente == 1) return 50
		else return 0
	}

}
// Categoria
class Categoria { var property neto }
object cadete inherits Categoria  { override method neto() = 1500 }
object gerente inherits Categoria { override method neto() = 1000 }
// Bono por resultados
class BonoPorResultados { var property valor }
object bono1 inherits BonoPorResultados { override method valor(empleado) = 0  }
object bono2 inherits BonoPorResultados { override method valor(empleado) = 80 }
object bono3 inherits BonoPorResultados { override method valor(empleado) = empleado.neto() / 10 }