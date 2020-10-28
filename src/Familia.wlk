import Armas.*
import Rangos.*
import Traicion.*

class Familia {
	const apellido
	var property donDeFamilia
	var property miembrosDeFamilia = #{}
	var property traiciones = #{}
	
	method mafiosoMasArmado(){
		return miembrosDeFamilia.filter({persona => persona.estaVivo()}).max({persona => persona.armas().size()})
	}
	
	method distribuirArmas(){
		miembrosDeFamilia.foreach({persona => persona.agregarArma(new Revolver(cantidadDeBalasDisponibles = 6, esSutil = false))})
	}
	
	method atacar(otraFamilia){
		const laFamiliaTienePersonasVivas = otraFamilia.miembrosDeFamilia().all({persona => persona.estaVivo()})
		if(laFamiliaTienePersonasVivas){
			miembrosDeFamilia.forEach({persona => persona.atacarA(otraFamilia.mafiosoMasArmado())})
		}
	}
	
	method elMasLealDe(miembros){
		return miembros.filter({persona => persona.estaVivo()}).max({persona => persona.lealtad()})
	}
	
	method iniciarTraicion(unaFechaTentativa, primeraVictima){
		traiciones.add(new Traicion(fechaTentativa = unaFechaTentativa, victimas = #{primeraVictima}))
	}
	
	method seComplicaUnaTraicion(unaTraicion, unaFechaTentativa, nuevaVictima){
		unaTraicion.seComplica(unaFechaTentativa, nuevaVictima)
	}
	
	method concretarTraicion(traidor, traicion, nuevaFamilia){
		if(self.validarSiSePuedeContretarTraicion(traidor)){
			traicion.concretarTraicion(traidor)
			self.quitarMiembro(traidor)
			traidor.aumentarLealtadEn(100)
			nuevaFamilia.agregarMiembro(traidor)
		} else {
			traidor.morirse()
		}
	}
	
	method validarSiSePuedeContretarTraicion(traidor){
		return self.lealtadPromedio() * 2 <= traidor.lealtad()
	}
	
	method quitarMiembro(miembroAQuitar){
		miembrosDeFamilia.remove(miembroAQuitar)
	}
	
	method agregarMiembro(miemroAAgregar){
		miembrosDeFamilia.add(miemroAAgregar)
	}
	
	method lealtadPromedio(){
		return miembrosDeFamilia.map({persona => persona.lealtad()}) / miembrosDeFamilia.size()
	}
	
	method reorganizarse(){
		const subjefes = miembrosDeFamilia.map({persona => persona.rango() == subjefe})
		miembrosDeFamilia.forEach({persona =>
			persona.aumentarLealtadEn(10)
			
			if(persona.rango() == subjefe){
				if(persona == self.elMasLealDe(subjefes) && persona.puedeConvertirseEnDon()){
					persona.cambiarRango(don)
					donDeFamilia = persona
				}
			}
			else if(persona.rango() == soldado){
				if(persona.puedeConvertirseEnSubjefe()){
					persona.cambiarRango(subjefe)
				}
			}
		})
	}
}

class MiembroDeFamilia {
	const nombre
	const property familia
	var rango
	var property armas = []
	var property estaVivo = true
	var property estaHerido = false
	var property lealtad
	
	method rango(){
		return rango
	}
	
	method cambiarRango(otroRango){
		const subordinadosAntes = rango.subordinados()
		rango = otroRango
		rango.heredarSubordinados(subordinadosAntes)
	}
	
	method herirse(){
		estaHerido = true
	}
	
	method morirse(){
		estaHerido = false
		estaVivo = false
		if(rango == don){
			familia.reorganizarse()
		}
	}
	
	method agregarArma(nuevaArma){
		armas.add(nuevaArma)
	}
	
	method aumentarLealtadEn(porcentaje){
		lealtad += (lealtad * porcentaje / 100)
	}
	
	method sabeDespacharElegantemente(){
		return rango.sabeDespacharElegantemente(armas)
	}
	
	method atacarA(unaPersona){
		rango.atacarA(unaPersona, armas)
	}
	
	method elegirArma(){
		rango.elegirArma(armas)
	}
	
	method puedeConvertirseEnDon(){
		return rango == subjefe && self.sabeDespacharElegantemente()
	}
	
	method puedeConvertirseEnSubjefe(){
		return rango == soldado && armas.size() > 5
	}
}
