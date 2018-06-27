require './Recorredor'
require './LectorDeArchivo'
require './CreadorDeEstados'
require './OrganizadorDeEstados'

class AFNEpsilon
  include CreadorDeEstados
  include OrganizadorDeEstados

  def initialize(archivoDescriptor)
    @lectorDeArchivo = LectorDeArchivo.new(archivoDescriptor)
    @estados = Array.new
  end

  def inicializarRecorredor
    puts "Ingrese la cadena a validar"
    print "> "
    cadenaAValidar = STDIN.gets.chomp()
    @recorredor = Recorredor.new(cadenaAValidar)
    @recorredor.asignarIndiceDeEstadoActual(@lectorDeArchivo.estadoInicial[0], @lectorDeArchivo.estados)
  end

  def recorrer
    @recorredor.recorrido << @lectorDeArchivo.estados[@recorredor.estadoActualIndice.to_i]
    #are we at a final state and are there no more transitions left? If so we are done
    if (@recorredor.estaEnEstadoFinal(@lectorDeArchivo) && @recorredor.noTieneMasTransiciones(@estados, @lectorDeArchivo)) && @recorredor.noHayMasSimbolosParaConsumir
      puts "#{@recorredor.recorrido}"
    else

      #else change recorredor's values in a loop so it moves on to all posible transitions with letter then with epsilon
      indiceDeSimboloActual = @lectorDeArchivo.alfabeto.index{|simbolo| simbolo == @recorredor.cadenaAValidar[@recorredor.posicionCadena]}

      if indiceDeSimboloActual != nil
        #maybe pop a value in recorrido and backtrack the position we are on the string currnetly being analyzed
        @estados[@recorredor.estadoActualIndice.to_i].transiciones[indiceDeSimboloActual].each do |estadoSiguienteID|
          @recorredor.posicionCadena += 1
          estadoActualTemp = @recorredor.estadoActualIndice
          @recorredor.estadoActualIndice = @lectorDeArchivo.estados.index(estadoSiguienteID)
          recorrer
          @recorredor.estadoActualIndice = estadoActualTemp
          @recorredor.posicionCadena -= 1
          @recorredor.recorrido.pop
        end
      end



      #if we backtracked from an epsilon their is no need to backtrack the string position
      indiceDeRenglonEpsilon = @lectorDeArchivo.alfabeto.length

      @estados[@recorredor.estadoActualIndice.to_i].transiciones[indiceDeRenglonEpsilon].each do |estadoSiguienteID|
        estadoActualTemp = @recorredor.estadoActualIndice
        @recorredor.estadoActualIndice = @lectorDeArchivo.estados.index(estadoSiguienteID)
        recorrer
        @recorredor.estadoActualIndice = estadoActualTemp
        @recorredor.recorrido.pop
      end

    end

  end

  def mostrarEstados
    @estados.each do |estado|
      estado.inspect
    end
  end
end

nombreDeArchivo =  ARGV[0]
afn = AFNEpsilon.new(nombreDeArchivo)
afn.crearEstados
afn.asignarTransiciones
afn.inicializarRecorredor
# afn.mostrarEstados
afn.recorrer
