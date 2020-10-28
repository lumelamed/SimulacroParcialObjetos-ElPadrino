class Familia {
	var property don
	var property miembrosDeFamilia = #{}
	
	method mafiosoMasArmado(){
		return miembrosDeFamilia.filter({persona => persona.estaVivo()}).max({persona => persona.armas().size()})
	}
}

class MiembroDeFamilia {
	var property estaVivo = true
	var property estaHerido = false
	
	method herirse(){
		estaHerido = true
	}
	
	method morirse(){
		estaHerido = false
		estaVivo = false
	}
}

class Don inherits MiembroDeFamilia {
	var property armas = []
	var property subordinados = #{}
	
	method atacarA(unaPersona){
		const unSubordinado = subordinados.anyOne()
		unSubordinado.atacarA(unaPersona)
		unSubordinado.atacarA(unaPersona)
	}
}

class Subjefe inherits MiembroDeFamilia {
	var property armas = []
	var property subordinados = #{}
	var property ultimaArmaUsada
	
	method elegirArma(){
		return armas.anyOne({arma => arma != ultimaArmaUsada})
	}
	
	method atacarA(unaPersona){
		self.elegirArma().atacarA(unaPersona)
	}
}

class Soldado inherits MiembroDeFamilia {
	var property armas = []
	
	method elegirArma(){
		return armas.anyOne()
	}
	
	method atacarA(unaPersona){
		self.elegirArma().atacarA(unaPersona)
	}
}