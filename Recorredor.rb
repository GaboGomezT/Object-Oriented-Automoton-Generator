class Recorredor
  attr_accessor :cadenaAValidar, :estadoActualIndice, :posicionCadena, :recorrido
  def initialize(cadenaAValidar)
    @cadenaAValidar = cadenaAValidar
    @estadoActualIndice = 0
    @posicionCadena = 0
    @recorrido = Array.new
  end

  def asignarIndiceDeEstadoActual(estadoActual, estados)
    @estadoActualIndice = estados.index {|estado| estado == estadoActual}
  end

  def estaEnEstadoFinal(lectorDeArchivo)
    if lectorDeArchivo.estadosFinales.include?(lectorDeArchivo.estados[@estadoActualIndice.to_i])
      return true
    else
      return false
    end
  end

  def noHayMasSimbolosParaConsumir
    if @posicionCadena >= @cadenaAValidar.length
      return true
    else
      return false
    end
  end

  def noTieneMasTransiciones(estados, lectorDeArchivo)

    indiceDeLetra = lectorDeArchivo.alfabeto.index { |letra| letra == @cadenaAValidar[@posicionCadena] }
    if indiceDeLetra == nil || estados[@estadoActualIndice.to_i].transiciones[indiceDeLetra].length == 0
      noHayTransicionConSimbolo = true
    else
      noHayTransicionConSimbolo = false
    end

    if estados[@estadoActualIndice.to_i].transiciones[lectorDeArchivo.alfabeto.length].length == 0
      noHayTransicionConEpsilon = true
    else
      noHayTransicionConEpsilon = false
    end

    if noHayTransicionConSimbolo && noHayTransicionConEpsilon
      return true
    else
      return false
    end

  end

  def inspect
    puts "Cadena a validar:#{@cadenaAValidar}"
    puts "estadoActualIndice: #{@estadoActualIndice}"
    puts "posicionCadena: #{@posicionCadena}"
    puts "recorrido: #{@recorrido}"
  end

end
