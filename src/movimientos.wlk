import wollok.game.*
import personajes.*

class Aleatorio {

	var posicion = game.at(0, 0)

	method posicion() = posicion

	method nuevaPosicion() {
		
		const x = 0.randomUpTo(5).truncate(0);
		const y = 0.randomUpTo(5).truncate(0);
		
		posicion = game.at(x, y)
	}

}

/*object aleatorioxd {

	var posicion = game.at(0, 0)

	method posicion() = posicion

	method nuevaPosicion() {
		
		const x = 0.randomUpTo(3).truncate(0);
		const y = 0.randomUpTo(4).truncate(0);
		
		posicion = game.at(x, y)
	}

}*/

object posicionFueraDeMapa {
    const posicion = game.at(7, 7)
    method posicion() = posicion
}

