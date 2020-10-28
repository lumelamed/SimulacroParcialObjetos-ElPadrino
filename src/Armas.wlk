class Revolver {
	var property cantidadDeBalasDisponibles
	
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
}

class Escopeta {
	method atacarA(unaPersona){
		if(unaPersona.estaHerida()){
			unaPersona.morirse()
		} else {
			unaPersona.herirse()
		}
	}
}

class CuerdaDePiano {
	const property esDeBuenaCalidad
	
	method atacarA(unaPersona){
		if(esDeBuenaCalidad){
			unaPersona.morirse()
		} 
	}
}