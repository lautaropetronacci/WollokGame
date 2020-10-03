import wollok.game.*
import movimientos.*
/*
object pepita {

	method position() {
		return game.center()
	}

	method image() {
		return "pepita.png"
	}

}*/

 object puntuacion {
 	method topoAplastado(){
 		
 	}
 }
 
 object vida {
 	var cantidadDeVida = 3
 	
 	method pierdeVida() {
 		cantidadDeVida = cantidadDeVida - 1
 	}
 }
 
 object martillo {
 	
 	var position = game.at(2, 2)
	var imagen = "martillo.png"

	method position() = position

	method moverseA(nuevaPosicion) {
		position = nuevaPosicion
	}

	method image() = imagen
 	
 	method golpe() {
 		imagen = "martilloGolpeando.png"
 		if (topo.position() == position){
 			game.removeVisual(topo)
 			puntuacion.topoAplastado()
 		}
 		else if (carpincho.position() == position) {
 			game.removeVisual(carpincho)
 			vida.pierdeVida()
 		}
 	}
 }
 
 object topo { 	
	const movimiento = aleatorio

	method position() = movimiento.posicion()

	method image() = "topo.png"

	method aplastadoPorMartillo() {
	}
 }
 
 object carpincho {
 	
	const movimiento = aleatorio

	method position() = movimiento.posicion()

	method image() = "carpincho.png"

	method aplastadoPorMartillo() {
	}
 }