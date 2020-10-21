import wollok.game.*
import personajes.*
import movimientos.*

object dontwhackthecapybara {

	const topo1 = new Topo()
	const topo2 = new Topo()
	const topo3 = new Topo()
	
	const boton1 = new Boton()
	const boton2 = new Boton2(position = game.at(5, 1)	)
	
	
	method iniciar() {
		self.configurarJuego()
		self.agregarPersonajes()
		self.configurarTeclas()
		self.configurarAcciones(1)
		game.start()
	}

	method configurarJuego() {
		game.title("Don't whack the capybara")
		game.width(6)
		game.height(5)
		game.cellSize(200)
		game.boardGround("fondo.png")
	}

	method agregarPersonajes() {
		/*game.addVisual(fondo)*/
		game.addVisual(boton1)
		game.addVisual(boton2)
		game.addVisual(carpincho)
		game.addVisual(topo1)
		game.addVisual(topo2)
		game.addVisual(topo3)
		game.addVisual(martillo)
		game.addVisual(tablero)
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

	method configurarAcciones(dificultad) {
		if (dificultad === 1){
		game.onTick(3600, "mover aleatoriamente carpincho", { carpincho.movimientoAleatorio().nuevaPosicion()})
		game.onTick(4500, "mover aleatoriamente", { topo1.movimientoAleatorio().nuevaPosicion()})
		game.onTick(4150, "mover aleatoriamente", { topo2.movimientoAleatorio().nuevaPosicion()})
		game.onTick(4640, "mover aleatoriamente", { topo3.movimientoAleatorio().nuevaPosicion()})
		} else if (dificultad === 2){
		game.onTick(2000, "mover aleatoriamente carpincho", { carpincho.movimientoAleatorio().nuevaPosicion()})
		game.onTick(2000, "mover aleatoriamente", { topo1.movimientoAleatorio().nuevaPosicion()})
		game.onTick(2000, "mover aleatoriamente", { topo2.movimientoAleatorio().nuevaPosicion()})
		game.onTick(2000, "mover aleatoriamente", { topo3.movimientoAleatorio().nuevaPosicion()})
		}
		else {
		game.onTick(100, "mover aleatoriamente carpincho", { carpincho.movimientoAleatorio().nuevaPosicion()})
		game.onTick(100, "mover aleatoriamente", { topo1.movimientoAleatorio().nuevaPosicion()})
		game.onTick(100, "mover aleatoriamente", { topo2.movimientoAleatorio().nuevaPosicion()})
		game.onTick(100, "mover aleatoriamente", { topo3.movimientoAleatorio().nuevaPosicion()})
		}
		
	}

}
