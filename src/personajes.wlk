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
 	var cantidadDeVida = 1
 	
 	method cantidadDeVida() = cantidadDeVida
 	
 	method pierdeVida() {
 		cantidadDeVida -= 1
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
 		game.schedule(500, { imagen = "martillo.png"})
 		if (topo.position() == position){
 			topo.aplastadoPorMartillo()
 		}
 		else if (carpincho.position() == position) {
 			carpincho.aplastadoPorMartillo()
 		}
 	}
 }
 
 object topo { 	 	
 	const imagen = "topo.png"

	const movimiento = aleatorio

	method position() = movimiento.posicion()

	method image() = imagen

	method aplastadoPorMartillo() {
		game.removeVisual(self)
 		puntuacion.topoAplastado()
 		game.schedule(8000, { game.addVisual(self)})
	}
 }

 object carpincho {
 	
	const movimiento = aleatorioxd

	method position() = movimiento.posicion()

	method image() = "carpincho.png"

	method aplastadoPorMartillo() {
		game.removeVisual(self)
 		vida.pierdeVida()
 		if (vida.cantidadDeVida() == 0){
 			game.say(self, "esto te pasa por tocar al carpincho")
 			game.schedule(5000, { game.stop()})
 		}
 		game.schedule(8000, { game.addVisual(self)})
	}
 }