import wollok.game.*
import movimientos.*
import Dontwhackthecapybara.*
import personajes.*

object tablero{
	const imagen = "score board.png"
	
	method position() = game.at(1,4)
	
	method image() = imagen
	
	method aplastadoPorMartillo(){}
}



object puntos{
    var puntos= 0
    const puntosParaGanar = 2000
    var property imagenUnidad = "imagenUnidad0.png"
    var property imagenDecena = "imagenDecena0.png"
    var property imagenCentena = "imagenCentena0.png"
    var property imagenMil = "imagenMil0.png"


    var property unidad = 0
    var property decena = 0
    var property centena = 0
    var property mil = 0
	
	method aplastadoPorMartillo(){}
	
	method puntos() = puntos
	
    method topoAplastado(puntosASumar){
        puntos += puntosASumar
        if(puntos == puntosParaGanar){
        	resultado.ganaste()
        }
        self.dividirNumeros(puntos)
        imagenUnidad = "imagenUnidad" + self.unidad().toString() +".png"
        imagenDecena = "imagenDecena" + self.decena().toString() +".png"
        imagenCentena ="imagenCentena" + self.centena().toString() +".png"
        imagenMil = "imagenMil" + self.mil().toString() +".png"
        
        unidadTablero.cambiarNumero(imagenUnidad)
        decenaTablero.cambiarNumero(imagenDecena)
        centenaTablero.cambiarNumero(imagenCentena)
        milTablero.cambiarNumero(imagenMil)
    }

    method dividirNumeros(numero){
        if (numero.digits()==2){
            decena = (numero / 10).truncate(0)
            unidad = numero - (decena * 10)
        }
        else if (numero.digits()==3){
            centena = (numero / 100).truncate(0)
            decena = ((numero - (centena*100))/10).truncate(0)
            unidad = numero - (centena*100 + decena*10)
        }
        else if(numero.digits()==4){
            mil = (numero / 1000).truncate(0)
            centena = ((numero - (mil * 1000) )/ 100).truncate(0)
            decena = ((numero - (mil * 1000 + centena*100))/10).truncate(0)
            unidad = numero - (mil * 1000 + centena*100 + decena*10)
        }
    }
    
    method reiniciar(){
      unidad = 0
      decena = 0
      centena = 0
      mil = 0
      self.topoAplastado( (-puntos))
    }
    
}



object unidadTablero {
	var imagen = "imagenUnidad0.png"

	method position() = game.at(2,4)

	method cambiarNumero(nuevoNumero) {
		imagen = nuevoNumero
	}
	
	method image() = imagen
	
	
}

object decenaTablero {
	var imagen = "imagenDecena0.png"

	method position() = game.at(2,4)

	method cambiarNumero(nuevoNumero) {
		imagen = nuevoNumero
	}
	
	method image() = imagen
}

object centenaTablero {
	var imagen = "imagenCentena0.png"

	method position() = game.at(1,4)

	method cambiarNumero(nuevoNumero) {
		imagen = nuevoNumero
	}
	
	method image() = imagen
}

object milTablero{
	var imagen = "imagenMil0.png"

	method position() = game.at(1,4)

	method cambiarNumero(nuevoNumero) {
		imagen = nuevoNumero
	}
	
	method image() = imagen
}




class BotonesGameOver {
	var property posicion = game.at(7, 7)
	
	method position() = posicion      							
	
	method moverAfuera(){
		posicion = posicionFueraDeMapa.posicion()
	}
}

object exitGame inherits BotonesGameOver {
	 
	 var imagen = "ExitGame.png"
	 
	 method image() = imagen
	 
	 method perder(){
	 	self.posicion(game.at(1,0)) 
	 }
	 
	 method aplastadoPorMartillo(){
	 	imagen = "ExitGameAplastado.png"
	 	game.schedule(500, { imagen = "ExitGame.png"})	
	 	game.schedule(1000, { game.stop()})
	 }
}

object playAgain inherits BotonesGameOver{
	
	var imagen = "PlayAgain.png"
	 
	method image() = imagen
	
	method perder(){
	 	self.posicion(game.at(1,1)) 
	 }
	
	method aplastadoPorMartillo(){
		imagen = "PlayAgainAplastado.png"
	 	game.schedule(500, { imagen = "PlayAgain.png"})
		game.schedule(1200, { dontwhackthecapybara.reiniciar()})
	} 
}



object vida {

	var property imagen = "3Vidas.png"

	var property cantidadDeVida = 3

	method position() = game.at(4,4)

	method image() = imagen
	
	method cantidadDeVida() = cantidadDeVida

	method pierdeVida() {
		cantidadDeVida -= 1
		imagen = cantidadDeVida.toString() + "Vidas.png"
		if (cantidadDeVida == 0) {
			resultado.perdiste()
		}
	}

}

object resultado{
	var imagen = "victoria.png"
	var property posicion = game.at(7,7)
	
	method perdiste() {
		imagen = "GameOver.png"
		dontwhackthecapybara.carpincho().movimiento(posicionFueraDeMapa)
		dontwhackthecapybara.topos().forEach({topo => topo.movimiento(posicionFueraDeMapa)})
		martillo.posicion(game.at(1,1))
		pantalla.perder()
		exitGame.perder()
		playAgain.perder()
		game.schedule(0, { self.posicion(game.at(0,0)) })
		
	}

	method ganaste() {
		game.schedule(0, { self.posicion(game.at(0,0)) })
        game.schedule(10000, { game.stop()})
        game.sound("snd_music_victorytheme.ogg").play()
	}


	method position() = posicion

	method image() = imagen


	method moverAfuera(){
		posicion = posicionFueraDeMapa.posicion()
	}
}
