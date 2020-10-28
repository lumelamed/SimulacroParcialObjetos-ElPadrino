class Traicion {
	var property victimas = #{}
	var property fechaTentativa
	var property estado = disponible
	
	method agregarVictima(nuevaVictima){
		victimas.add(nuevaVictima)
	}
	
	method seComplica(nuevaFecha, nuevaVictima){
		self.estado(desbaratada)
		self.fechaTentativa(nuevaFecha)
		self.agregarVictima(nuevaVictima)
	}
	
	method concretarTraicion(traidor){
		self.estado(consumada)
		victimas.forEach({victima => traidor.atacarA(victima)})
	}
}

object consumada{}
object desbaratada{}
object disponible{}
