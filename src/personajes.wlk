import wollok.game.*
import movimientos.*
import Dontwhackthecapybara.*

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

object milTablero {
	var imagen = "imagenMil0.png"

	method position() = game.at(1,4)

	method cambiarNumero(nuevoNumero) {
		imagen = nuevoNumero
	}
	
	method image() = imagen
}


object vida {

	var imagen = "3Vidas.png"

	var property cantidadDeVida = 3

	method position() = game.at(4,4)

	method image() = imagen
	
	method cantidadDeVida() = cantidadDeVida

	method pierdeVida() {
		cantidadDeVida -= 1
		imagen = cantidadDeVida.toString() + "Vidas.png"
	}

}

object pantalla {
	
	var limiteDePantallaAlto = game.height() - 1
	var limiteDePantallaAncho = game.width() - 1
	
	method perder(){
		limiteDePantallaAlto = 1
		limiteDePantallaAncho = 0
	}
	
	
	method enPantalla(posicion) = posicion.x().between(0,  limiteDePantallaAncho) && posicion.y().between(0, limiteDePantallaAlto)

}

class BotonSubirDificultad {
	var property dificultad = 1

	const position = game.at(5, 3)
	var imagen = "boton.png"


	method position() = position

	method image() = imagen
	
	method aplastadoPorMartillo() {
		imagen = "botonGolpeado.png"
		game.schedule(550, { imagen = "boton.png"})
		self.modificarDificultad()
		dontwhackthecapybara.configurarAcciones(dificultad);
	}
	
	method modificarDificultad(){
		if (dificultad < 3) dificultad ++
	}
}

class BotonBajarDificultad inherits BotonSubirDificultad {
	
	override method modificarDificultad(){
		if (dificultad > 1) dificultad --
	}
	
	
}

class BotonesGameOver {
	var position = game.at(7, 7)
	
	method perder(){
		position = game.at(0,0)
	}
}

object exitGame inherits BotonesGameOver {
	 
	 var imagen = "ExitGame.png"
	 
	 method image() = imagen
	 
	 method aplastadoPorMartillo(){
	 imagen = "ExitGameAplastado.png"
	 game.schedule(500, { imagen = "ExitGame.png"})	
	 game.schedule(500, { game.stop()})
	 }
}

//object playAgain inherits BotonesGameOver{
	
	//var imagen = "PlayAgain.png"
	 
	 //method image() = imagen
	
	//method aplastadoPorMartillo() = 
//}



object martillo {

	var position = game.at(2, 2)
	var imagen = "martillo.png"

	method position() = position

	method moverseA(nuevaPosicion) {
		if (pantalla.enPantalla(nuevaPosicion)) {
			position = nuevaPosicion
		}
	}

	method image() = imagen

	method golpe() {
		imagen = "martilloGolpeando.png"
		game.schedule(500, { imagen = "martillo.png"})
		if (not game.colliders(self).isEmpty()){
			game.colliders(self).first().aplastadoPorMartillo()
		}
	}

}






class Animal {
	const imagen = null
	const property movimientoAleatorio = new Aleatorio()
	var movimiento = movimientoAleatorio
	var milisegundos = 3600

	method position() = movimiento.posicion()

	method image() = imagen
	
	method agregarOnTick(){
		game.onTick(milisegundos, "mover aleatoriamente", { self.movimientoAleatorio().nuevaPosicion()})
	}

}


class Carpincho inherits Animal{

	method aplastadoPorMartillo() {
		game.schedule(4000, { movimiento = movimientoAleatorio})
		vida.pierdeVida()
		if (vida.cantidadDeVida() == 0) {
			resultado.perdiste()
		} else {
			movimiento = posicionFueraDeMapa
		}
	}

}

class Topo inherits Animal{

	method aplastadoPorMartillo() {
		movimiento = posicionFueraDeMapa
		game.schedule(3800, { movimiento = movimientoAleatorio})
		puntos.topoAplastado(50)
	}
	
}

object tablero{
	const imagen = "score board.png"
	
	method position() = game.at(1,4)
	
	method image() = imagen
	
	method aplastadoPorMartillo(){}
}

object resultado{
	var imagen = "victoria.png"
	var property posicion = game.at(7,7)
	
	method perdiste() {
		imagen = "GameOver.png"
		pantalla.perder()
		exitGame.perder()
		game.schedule(0, { self.posicion(game.at(0,0)) })
        game.schedule(10000, { game.stop()})
	}
	
	method ganaste() {
		game.schedule(0, { self.posicion(game.at(0,0)) })
        game.schedule(10000, { game.stop()})
        game.sound("snd_music_victorytheme.ogg").play()
	}
	
	method position() = posicion
	
	method image() = imagen
	
	method aplastadoPorMartillo(){}
}