import wollok.game.*
import movimientos.*
import Dontwhackthecapybara.*

object puntos{
    var puntos= 0
    var property imagenUnidad = "imagenUnidad0.png"
    var property imagenDecena = "imagenDecena0.png"
    var property imagenCentena = "imagenCentena0.png"
    var property imagenMil = "imagenMil0.png"
    
   
  

    var property unidad = 0
    var property decena = 0
    var property centena = 0
    var property mil = 0
	
	var property imagen = "victoria.png"
	var property posicion = game.at(7,7)
	
	method position() = posicion
	
	method image() = imagen
	
	method aplastadoPorMartillo(){}
	
	method puntos() = puntos
	
    method topoAplastado(){
        puntos +=50 
        if(puntos == 100){
        	game.schedule(0, { self.posicion(game.at(1,1)) })
        	game.schedule(10000, { game.stop()})
        	game.sound("snd_music_victorytheme.ogg")
        }
        self.dividirNumeros(puntos)
        imagenUnidad = "imagenUnidad" + self.unidad().toString() +".png"
        imagenDecena = "imagenDecena" + self.decena().toString() +".png"
        imagenCentena ="imagenCentena" + self.centena().toString() +".png"
        imagenMil = "imagenMil" + self.mil().toString() +".png"
    }

    method dividirNumeros(numero){
        if (numero.digits()==2){
            decena = numero / 10
            unidad = numero - (decena * 10)
        }
        else if (numero.digits()==3){
            centena = numero / 100
            decena = (numero - (centena*100))/10
            unidad = numero - (centena*100 + decena*10)
        }
        else if(numero.digits()==4){
            mil = numero / 1000
            centena = (numero - (mil * 1000) )/ 100
            decena = (numero - (mil * 1000 + centena*100))/10
            unidad = numero - (mil * 1000 + centena*100 + decena*10)
        }
    }
    
}
  

object vida {

	var cantidadDeVida = 3

	method cantidadDeVida() = cantidadDeVida

	method pierdeVida() {
		cantidadDeVida -= 1
	}

}

object pantalla {

	method enPantalla(posicion) = posicion.x().between(0, game.width() - 1) && posicion.y().between(0, game.height() - 1)

}

class Boton {
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

class Boton2 inherits Boton {
	
	override method modificarDificultad(){
		if (dificultad > 1) dificultad --
	}
	
	
}



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

object topo {

	const imagen = "topo.png"
	const property movimientoAleatorio = new Aleatorio()
	var movimiento = movimientoAleatorio

	method position() = movimiento.posicion()

	method image() = imagen

	method aplastadoPorMartillo() {
		movimiento = posicionFueraDeMapa
		game.schedule(3800, { movimiento = movimientoAleatorio})
		puntos.topoAplastado()
	}

}

object carpincho {

	const property movimientoAleatorio = new Aleatorio()
	var movimiento = movimientoAleatorio

	method position() = movimiento.posicion()

	method image() = "carpincho.png"

	method aplastadoPorMartillo() {
		game.schedule(4800, { movimiento = movimientoAleatorio})
			// game.removeVisual(self)
		vida.pierdeVida()
		if (vida.cantidadDeVida() == 0) {
			game.say(self, "sabes que esto significa... la guerra")
			game.schedule(5000, { game.stop()})
		} else {
			movimiento = posicionFueraDeMapa
		}
	// game.schedule(8000, { game.addVisual(self)})
	}

}

class Topo {

	const imagen = "topo.png"
	const property movimientoAleatorio = new Aleatorio()
	var movimiento = movimientoAleatorio

	method position() = movimiento.posicion()

	method image() = imagen

	method aplastadoPorMartillo() {
		movimiento = posicionFueraDeMapa
		game.schedule(3800, { movimiento = movimientoAleatorio})
		puntos.topoAplastado()
	}

}

object tablero{
	const imagen = "score board.png"
	
	method position() = game.at(2,4)
	
	method image() = imagen
	
	method aplastadoPorMartillo(){}
}

/*object victoria{
	const imagen = "victoria.png"
	
	method position() = game.at(1,1)
	
	method image() = imagen
	
	method aplastadoPorMartillo(){}
}*/
/*
 object fondo{
	
	method position() = game.at(1,1)
	
	method image() = "fondo.png"
	
	method aplastadoPorMartillo(){}
}*/