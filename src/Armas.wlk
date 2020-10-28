class Revolver {
	var property cantidadDeBalasDisponibles
	var property esSutil
	
	method atacarA(unaPersona){
		if(self.puedeDisparar()){
			unaPersona.morirse()
			self.gastarUnaBala()
		}
	}
	
	method gastarUnaBala(){
		cantidadDeBalasDisponibles --
	}
	
	method puedeDisparar(){
		return self.quedanBalasDisponibles()
	}
	
	method quedanBalasDisponibles(){
		return cantidadDeBalasDisponibles > 0
	}
	
	method esSutil(){
		return cantidadDeBalasDisponibles == 1
	}
}

class Escopeta {
	var property esSutil = false
	
	method atacarA(unaPersona){
		if(unaPersona.estaHerida()){
			unaPersona.morirse()
		} else {
			unaPersona.herirse()
		}
	}
}

class CuerdaDePiano {
	const esDeBuenaCalidad
	var property esSutil = true 
	
	method atacarA(unaPersona){
		if(esDeBuenaCalidad){
			unaPersona.morirse()
		} 
	}
}