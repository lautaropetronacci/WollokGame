import wollok.game.*
import movimientos.*

object puntuacion {
	var puntos = 0
	
	method puntos() = puntos 
	
	method topoAplastado() {
		puntos += 50
	}

}

object vida {

	var cantidadDeVida = 3

	method cantidadDeVida() = cantidadDeVida

	method pierdeVida() {
		cantidadDeVida -= 1
	}

}

object pantalla {

	method enPantalla(posicion) = posicion.x().between(0, game.width() - 1) && posicion.y().between(0, game.height() - 1)

}

object martillo {

	var position = game.at(2, 2)
	var imagen = "martillo.png"

	method position() = position

	method moverseA(nuevaPosicion) {
		if (pantalla.enPantalla(nuevaPosicion)) {
			position = nuevaPosicion
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

object topo {

	const imagen = "topo.png"
	const property movimientoAleatorio = new Aleatorio()
	var movimiento = movimientoAleatorio

	method position() = movimiento.posicion()

	method image() = imagen

	method aplastadoPorMartillo() {
		movimiento = posicionFueraDeMapa
		game.schedule(3800, { movimiento = movimientoAleatorio})
		puntuacion.topoAplastado()
	}

}

object carpincho {

	const property movimientoAleatorio = new Aleatorio()
	var movimiento = movimientoAleatorio

	method position() = movimiento.posicion()

	method image() = "carpincho.png"

	method aplastadoPorMartillo() {
		game.schedule(4800, { movimiento = movimientoAleatorio})
			// game.removeVisual(self)
		vida.pierdeVida()
		if (vida.cantidadDeVida() == 0) {
			game.say(self, "sabes que esto significa... la guerra")
			game.schedule(5000, { game.stop()})
		} else {
			movimiento = posicionFueraDeMapa
		}
	// game.schedule(8000, { game.addVisual(self)})
	}

}

class Topo {

	const imagen = "topo.png"
	const property movimientoAleatorio = new Aleatorio()
	var movimiento = movimientoAleatorio

	method position() = movimiento.posicion()

	method image() = imagen

	method aplastadoPorMartillo() {
		movimiento = posicionFueraDeMapa
		game.schedule(3800, { movimiento = movimientoAleatorio})
		puntuacion.topoAplastado()
	}

}

object tablero{
	const imagen = "score board.png"
	
	method position() = game.at(2,4)
	
	method image() = imagen
	
	method aplastadoPorMartillo(){}
}


object fondo{
	
	method position() = game.at(1,1)
	
	method image() = "martillo.png"
	
	method aplastadoPorMartillo(){}
}