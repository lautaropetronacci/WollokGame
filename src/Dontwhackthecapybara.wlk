import wollok.game.*
import personajes.*
import movimientos.*

object dontwhackthecapybara {


	const property topos = #{new Topo(imagen = "topo.png"),new Topo(imagen = "topo.png"),new Topo(imagen = "topo.png") }
	const property carpincho = new Carpincho(imagen = "carpincho.png")
	
	const botonSubirDificultad = new BotonSubirDificultad()
	const botonBajarDificultad= new BotonBajarDificultad(position = game.at(5, 1)	)
	
	
	method iniciar() {
		self.configurarJuego()
		self.agregarPersonajes()
		self.configurarTeclas()
		self.configurarAcciones(1)
		self.activarAnimales()
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
		game.addVisual(botonSubirDificultad)
		game.addVisual(botonBajarDificultad)
		game.addVisual(carpincho)
		topos.forEach({topo => game.addVisual(topo)})
		game.addVisual(tablero)
		game.addVisual(vida)
		game.addVisual(unidadTablero)
		game.addVisual(decenaTablero)
		game.addVisual(centenaTablero)
		game.addVisual(milTablero)
		game.addVisual(exitGame)
		game.addVisual(martillo)
		game.addVisual(resultado)
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
		//self.agregarOnTick(3600, 4500, 4150,4640)
		} else if (dificultad === 2){
		//self.agregarOnTick(2000, 2100, 2150, 2200)
		}
		else {
		//self.agregarOnTick(100, 100, 100,100)
		}
	}
		
	method activarAnimales(){
		topos.forEach({topo => topo.agregarOnTick()})
		carpincho.agregarOnTick()
	}		

	
	

/* lista de topos en donde se le envie a cada topo sobre cambiar su velocidad */


    /*method agregarOnTick(miliSegCarpincho, miliSegTopo1, miliSegTopo2,miliSegTopo3){
        game.onTick(miliSegCarpincho, "mover aleatoriamente carpincho", { carpincho.movimientoAleatorio().nuevaPosicion()})
        game.onTick(miliSegTopo1, "mover aleatoriamente topo1", { topo1.movimientoAleatorio().nuevaPosicion()})
        game.onTick(miliSegTopo2, "mover aleatoriamente topo2", { topo2.movimientoAleatorio().nuevaPosicion()})
        game.onTick(miliSegTopo3, "mover aleatoriamente topo3", { topo3.movimientoAleatorio().nuevaPosicion()})
}*/

	

}
