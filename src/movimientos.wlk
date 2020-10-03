import wollok.game.*
import personajes.*

object aleatorio {

	var posicion = game.at(0, 0)

	method posicion() = posicion

	method nuevaPosicion() {
		// calculo coordenadas aleatorias dentro la pantalla
		const x = 0.randomUpTo(game.width(2))
		const y = 0.randomUpTo(game.height(3))
		// cambio a nueva posicion
		posicion = game.at(x, y)
	}

}


