import Familia.*

object don {
	var property subordinados = #{}
	
	method elegirArma(armas){
		const unSubordinado = subordinados.anyOne()
		return unSubordinado.elegirArma(armas)
	}
	
	method atacarA(unaPersona, armas){
		const unSubordinado = subordinados.anyOne()
		unSubordinado.atacarA(unaPersona)
		unSubordinado.atacarA(unaPersona)
	}
	
	method sabeDespacharElegantemente(armas){
		return true
	}
	
	method heredarSubordinados(unosSubordinados){
		subordinados = unosSubordinados
	}
}

object subjefe {
	var property subordinados = #{}
	var property ultimaArmaUsada
	
	method elegirArma(armas){
		return armas.anyOne({arma => arma != ultimaArmaUsada})
	}
	
	method atacarA(unaPersona, armas){
		const arma = self.elegirArma(armas)
		arma.atacarA(unaPersona)
		self.actualizarUltimaArma(arma)
	}
	
	method sabeDespacharElegantemente(armas){
		return subordinados.anyOne().sabeDespacharElegantemente(armas)
	}
	
	method actualizarUltimaArma(arma){
		ultimaArmaUsada = arma
	}
	
	method heredarSubordinados(unosSubordinados){
		subordinados = unosSubordinados
	}
}

object soldado {
	var property subordinados = #{} // siempre vacio
	
	method elegirArma(armas){
		return armas.anyOne()
	}
	
	method atacarA(unaPersona, armas){
		self.elegirArma(armas).atacarA(unaPersona)
	}
	
	method sabeDespacharElegantemente(armas){
		return armas.anyOne({arma => arma.esSutil()})
	}
	
	method heredarSubordinados(unosSubordinados){}
}