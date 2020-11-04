import wollok.game.*
import personajes.*
import movimientos.*
import interfaz.*
object dontwhackthecapybara {


	const property topos = #{new Topo(imagen = "topo.png"),new Topo(imagen = "topo.png"),new Topo(imagen = "topo.png") }
	const property carpincho = new Carpincho(imagen = "carpincho.png")
	
	const botonSubirDificultad = new BotonDificultad(tipoDeBoton = subirDificultad)
	const botonBajarDificultad= new BotonDificultad(position = game.at(5, 1), tipoDeBoton = bajarDificultad)
	
	
	method iniciar() {
		self.configurarJuego()
		self.agregarPersonajes()
		self.configurarTeclas()
		self.configurarAcciones()
		game.start()
		
	}

	method configurarJuego() {
		game.title("Don't whack the capybara")
		game.width(8)
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
		game.addVisual(playAgain)
		game.addVisual(martillo)
		game.addVisual(resultado)
		game.addVisual(nivelDeDificultad)
		game.addVisual(reloj)
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

		
	method configurarAcciones(){
		topos.forEach({topo => topo.agregarOnTick()})
		carpincho.agregarOnTick()
		reloj.agregarOnTick()
	}
	
	method reiniciar(){
		exitGame.moverAfuera() 
		playAgain.moverAfuera()
		vida.imagen("3Vidas.png")
		vida.cantidadDeVida(3)
		resultado.moverAfuera()
		puntos.reiniciar()
		pantalla.reiniciar()
		reloj.reiniciar()
		game.addVisual(carpincho)
		self.topos().forEach({topo => game.addVisual(topo)})
		game.removeVisual(martillo)
		game.addVisual(martillo)
	}



}
