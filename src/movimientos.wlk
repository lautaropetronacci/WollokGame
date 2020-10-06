import wollok.game.*
import personajes.*

object aleatorio {

	var posicion = game.at(0, 0)

	method posicion() = posicion

	method nuevaPosicion() {
		
		const x = 0.randomUpTo(2)
		const y = 0.randomUpTo(3)
		
		posicion = game.at(x, y)
	}

}


