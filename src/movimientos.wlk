import wollok.game.*
import personajes.*

object aleatorio {

	var posicion = game.at(0, 0)

	method posicion() = posicion

	method nuevaPosicion() {
		
		const x = 0.randomUpTo(3).truncate(0);
		const y = 0.randomUpTo(4).truncate(0);
		
		posicion = game.at(x, y)
	}

}

object aleatorioxd {

	var posicion = game.at(0, 0)

	method posicion() = posicion

	method nuevaPosicion() {
		
		const x = 0.randomUpTo(3).truncate(0);
		const y = 0.randomUpTo(4).truncate(0);
		
		posicion = game.at(x, y)
	}

}

object posicionFueraDeMapa {
    const posicion = game.at(3, 3)
    method posicion() = posicion
}

