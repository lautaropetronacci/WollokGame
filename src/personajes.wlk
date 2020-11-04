import wollok.game.*
import movimientos.*
import Dontwhackthecapybara.*
import interfaz.*



object pantalla {
	
	var limiteDePantallaSuperior = game.height() - 2
	var limiteDePantallaDerecha = game.width() - 1
	var limiteDePantallaIzquierda = 0
	
	method perder(){
		limiteDePantallaSuperior = 1
		limiteDePantallaDerecha = 1
		limiteDePantallaIzquierda = 1
	}
	
	method reiniciar(){
		limiteDePantallaSuperior = game.height() - 2
		limiteDePantallaDerecha = game.width() - 1
		limiteDePantallaIzquierda = 0
	}
	
	
	method enPantalla(posicion) = posicion.x().between(limiteDePantallaIzquierda,  limiteDePantallaDerecha) && posicion.y().between(0, limiteDePantallaSuperior)

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
		//game.onTick(milisegundos, "mover aleatoriamente", { self.movimientoAleatorio().nuevaPosicion()})
		game.onTick((milisegundos - milisegundos/6).randomUpTo(milisegundos + milisegundos/6), "mover aleatoriamente", { self.movimientoAleatorio().nuevaPosicion()})
		//forma para randomizar la aparicion de los animales y que no se muevan todos al mismo tiempo
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
	
	const tipoDeBoton
	
	method position() = position

	method image() = imagen
	
	method aplastadoPorMartillo() {
		imagen = "botonGolpeado.png"
		game.schedule(550, { imagen = "boton.png"})
		tipoDeBoton.modificarDificultad(milisegundos)
	}
	
	
}


object subirDificultad{
	
	method modificarDificultad(milisegundosARestar){
    	dontwhackthecapybara.carpincho().subirVelocidad(milisegundosARestar)
    	dontwhackthecapybara.topos().forEach({topo => topo.subirVelocidad(milisegundosARestar)})
    	nivelDeDificultad.cambiarNivelDificultad(1)
    }
}

object bajarDificultad{
	
	
	
	method modificarDificultad(milisegundosASumar){
	    dontwhackthecapybara.carpincho().bajarVelocidad(milisegundosASumar)
	    dontwhackthecapybara.topos().forEach({topo => topo.bajarVelocidad(milisegundosASumar)})
	    nivelDeDificultad.cambiarNivelDificultad(-1)
	}
	
	
}

object nivelDeDificultad{
	const posicion = game.at(5,2)
	var property imagen = "imagenDificultad1.png"
	var nivel = 1
	
	method nivel()= nivel
	
	method position() = posicion
	
	method image() = imagen
	
	method cambiarNivelDificultad(numero){
		nivel = 0.max(nivel + numero).min(4)
		imagen = "imagenDificultad" + nivel.toString() +".png"
	}
	
	
		
}



