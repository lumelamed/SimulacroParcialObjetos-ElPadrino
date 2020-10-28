import Armas.*

class Familia {
	var property don
	var property miembrosDeFamilia = #{}
	
	method mafiosoMasArmado(){
		return miembrosDeFamilia.filter({persona => persona.estaVivo()}).max({persona => persona.armas().size()})
	}
	
	method distribuirArmas(){
		miembrosDeFamilia.foreach({persona => persona.agregarArma(new Revolver(cantidadDeBalasDisponibles = 6))})
	}
	
	method atacar(otraFamilia){
		const laFamiliaTienePersonasVivas = otraFamilia.miembrosDeFamilia().all({persona => persona.estaVivo()})
		if(laFamiliaTienePersonasVivas){
			miembrosDeFamilia.forEach({persona => persona.atacarA(otraFamilia.mafiosoMasArmado())})
		}
	}
}

class MiembroDeFamilia {
	var property armas = []
	var property estaVivo = true
	var property estaHerido = false
	
	method herirse(){
		estaHerido = true
	}
	
	method morirse(){
		estaHerido = false
		estaVivo = false
	}
	
	method agregarArma(nuevaArma){
		armas.add(nuevaArma)
	}
}

class Don inherits MiembroDeFamilia {
	var property subordinados = #{}
	
	method elegirArma(){
		const unSubordinado = subordinados.anyOne()
		return unSubordinado.elegirArma()
	}
	
	method atacarA(unaPersona){
		const unSubordinado = subordinados.anyOne()
		unSubordinado.atacarA(unaPersona)
		unSubordinado.atacarA(unaPersona)
	}
	
	method sabeDespacharElegantemente(){
		return true
	}
}

class Subjefe inherits MiembroDeFamilia {
	var property subordinados = #{}
	var property ultimaArmaUsada
	
	method elegirArma(){
		return armas.anyOne({arma => arma != ultimaArmaUsada})
	}
	
	method atacarA(unaPersona){
		self.elegirArma().atacarA(unaPersona)
	}
	
	method sabeDespacharElegantemente(){
		subordinados.anyOne().sabeDespacharElegantemente()
	}
}

class Soldado inherits MiembroDeFamilia {
	method elegirArma(){
		return armas.anyOne()
	}
	
	method atacarA(unaPersona){
		self.elegirArma().atacarA(unaPersona)
	}
	
	method sabeDespacharElegantemente(){
		return armas.anyOne({arma => arma.esSutil()})
	}
}