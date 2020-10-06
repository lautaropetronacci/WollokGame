import wollok.game.*
import personajes.*
import movimientos.*

object dontwhackthecapybara {

	method iniciar() {
		self.configurarJuego()
		self.agregarPersonajes()
		self.configurarTeclas()
		self.configurarAcciones()
		game.start()
	}

	method configurarJuego() {
		game.title("Don't whack the capybara")
		game.width(5)
		game.height(5)
		game.cellSize(150)
	}

	method agregarPersonajes() {
		game.addVisual(martillo)
	}

	method configurarTeclas() {
		keyboard.up().onPressDo({ martillo.moverseA(martillo.position().up(1))})
		keyboard.down().onPressDo({ martillo.moverseA(martillo.position().down(1))})
		keyboard.left().onPressDo({ martillo.moverseA(martillo.position().left(1))})
		keyboard.right().onPressDo({ martillo.moverseA(martillo.position().right(1))})
		keyboard.space().onPressDo({ 
			martillo.golpe()
			})
	}

	method configurarAcciones() {
		game.onTick(4000, "mover aleatoriamente", { aleatorio.nuevaPosicion()})
		
	}

}
