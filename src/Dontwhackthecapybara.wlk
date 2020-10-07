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
		game.cellSize(200)
	}

	method agregarPersonajes() {
		game.addVisual(carpincho)
		game.addVisual(topo)
		game.addVisual(topo2)
		game.addVisual(topo3)
		game.addVisual(martillo)
	}

	method configurarTeclas() {
		keyboard.up().onPressDo({ martillo.moverseA(martillo.position().up(1))})
		keyboard.down().onPressDo({ martillo.moverseA(martillo.position().down(1))})
		keyboard.left().onPressDo({ martillo.moverseA(martillo.position().left(1))})
		keyboard.right().onPressDo({ martillo.moverseA(martillo.position().right(1))})
		keyboard.space().onPressDo({ martillo.golpe() })
	}

	method configurarAcciones() {
		game.onTick(4350, "mover aleatoriamente", { topo.movimientoAleatorio().nuevaPosicion()})
		game.onTick(3600, "mover aleatoriamente carpincho", { carpincho.movimientoAleatorio().nuevaPosicion()})
		game.onTick(4150, "mover aleatoriamente", { topo2.movimientoAleatorio().nuevaPosicion()})
		game.onTick(4640, "mover aleatoriamente", { topo3.movimientoAleatorio().nuevaPosicion()})
	}

}
