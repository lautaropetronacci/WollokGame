import wollok.game.*
import movimientos.*

class NumeroPuntuacion{
	var property position = game.at(1, 4)

	var imagen = "imagen 0.png"

	method CambiarNumero(nuevoNumero) {
		imagen = nuevoNumero
	}

	method position() = position

	method image() = imagen
}

object unidadTablero inherits NumeroPuntuacion {
	override method position() = game.at(2, 4)
}

object decenaTablero inherits NumeroPuntuacion {
	override method position() = game.at(2, 4)
}

object centenaTablero inherits NumeroPuntuacion {
	
}

object milTablero inherits NumeroPuntuacion {
	
}

object puntos{
    var property puntos = 0
    var property imagenMil = "imagen 0.png"
    var property imagenCentena = "imagen 0.png"
    var property imagenDecena = "imagen 0.png"
    var property imagenUnidad = "imagen 0.png"
    

    var property unidad = 0
    var property decena = 0
    var property centena = 0
    var property mil = 0
	
    method topoAplastado(){
        puntos +=50 
        self.dividirNumeros(puntos)
        imagenUnidad = "imagen " + self.unidad().toString() +".png"
        imagenDecena = "imagen " + self.decena().toString() +".png"
        imagenCentena = "imagen " + self.centena().toString() +".png"
        imagenUnidad = "imagen " + self.mil().toString() +".png"
        unidadTablero.CambiarNumero(imagenUnidad)
        decenaTablero.CambiarNumero(imagenDecena)
        centenaTablero.CambiarNumero(imagenCentena)
        milTablero.CambiarNumero(imagenMil)
    }

    method dividirNumeros(numero){
        if (numero.digits()==2){
            decena = numero / 10
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

object boton {

	const position = game.at(5, 3)
	var imagen = "boton.png"


	method position() = position

	method image() = imagen
	
	method aplastadoPorMartillo() {
		imagen = "botonGolpeado.png"
		game.schedule(550, { imagen = "boton.png"})
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
	
	method position() = game.at(1,4)
	
	method image() = imagen
	
	method aplastadoPorMartillo(){}
}

/*
 object fondo{
	
	method position() = game.at(1,1)
	
	method image() = "fondo.png"
	
	method aplastadoPorMartillo(){}
}*/