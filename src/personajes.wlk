import wollok.game.*
import movimientos.*
import Dontwhackthecapybara.*
import interfaz.*



object pantalla {
	
	var limiteDePantallaAlto = game.height() - 2
	var limiteDePantallaAncho = game.width() - 1
	
	method perder(){
		limiteDePantallaAlto = 1
		limiteDePantallaAncho = 1
	}
	
	method reiniciar(){
		limiteDePantallaAlto = game.height() - 2
		limiteDePantallaAncho = game.width() - 1
	}
	
	
	method enPantalla(posicion) = posicion.x().between(0,  limiteDePantallaAncho) && posicion.y().between(0, limiteDePantallaAlto)

}


object martillo {

	var property posicion = game.at(2, 2)
	var imagen = "martillo.png"

	method position() = posicion

	method moverseA(nuevaPosicion) {
		if (pantalla.enPantalla(nuevaPosicion)) {
			posicion = nuevaPosicion
		}
	}

	method image() = imagen

	method golpe() {
		imagen = "martilloGolpeando.png"
		game.schedule(500, { imagen = "martillo.png"})
		if (not game.colliders(self).isEmpty()){
			game.colliders(self).first().aplastadoPorMartillo()
		}
	}
}



class Animal {
	const imagen = null
	const property movimientoAleatorio = new Aleatorio()
	var property movimiento = movimientoAleatorio
	var property milisegundos = 3600

	method position() = movimiento.posicion()

	method image() = imagen
	
	method agregarOnTick(){
		game.onTick(milisegundos, "mover aleatoriamente", { self.movimientoAleatorio().nuevaPosicion()})
	}
	
	method subirVelocidad(milisegundosARestar){
	    milisegundos = 600.max(milisegundos - milisegundosARestar)
	    game.removeTickEvent("mover aleatoriamente") // ver si hay que cambiar nombre del onTick
	    self.agregarOnTick()
	}
	
	method bajarVelocidad(milisegundosASumar){
	    milisegundos = 4600.min(milisegundos + milisegundosASumar)
	    game.removeTickEvent("mover aleatoriamente")// ver si hay que cambiar nombre del onTick
	    self.agregarOnTick()
	}

	method aplastadoPorMartillo() {
		movimiento = posicionFueraDeMapa
		game.schedule(milisegundos, { movimiento = movimientoAleatorio})
		}
}


class Carpincho inherits Animal{

	override method aplastadoPorMartillo() {
		super()
		vida.pierdeVida()
	}

}

class Topo inherits Animal{

	override method aplastadoPorMartillo() {
		super()
		puntos.topoAplastado(50)
	}
	
}

class BotonDificultad{

	const position = game.at(5, 3)
	
	var imagen = "boton.png"
	
	const milisegundos = 1000

	method position() = position

	method image() = imagen
	
	method aplastadoPorMartillo() {
		imagen = "botonGolpeado.png"
		game.schedule(550, { imagen = "boton.png"})
		self.modificarDificultad(milisegundos)
	}
	
	method modificarDificultad(tiempo){}
	
}


class BotonSubirDificultad inherits BotonDificultad{
	
	
	override method modificarDificultad(milisegundosARestar){
    dontwhackthecapybara.carpincho().subirVelocidad(milisegundosARestar)
    dontwhackthecapybara.topos().forEach({topo => topo.subirVelocidad(milisegundosARestar)})
    nivelDeDificultad.cambiarNivelDificultad(1)
    }
}

class BotonBajarDificultad inherits BotonDificultad{
	
	override method modificarDificultad(milisegundosASumar){
	    dontwhackthecapybara.carpincho().bajarVelocidad(milisegundosASumar)
	    dontwhackthecapybara.topos().forEach({topo => topo.bajarVelocidad(milisegundosASumar)})
	    nivelDeDificultad.cambiarNivelDificultad(-1)
	}
	
	
}

object nivelDeDificultad{
	const posicion = game.at(5,2)
	var property imagen = "imagenDificultad1.png"
	var nivel = 1
	
	method position() = posicion
	
	method image() = imagen
	
	method cambiarNivelDificultad(numero){
		nivel = 0.max(nivel + numero).min(4)
		imagen = "imagenDificultad" + nivel.toString() +".png"
	}
	
	
		
}



