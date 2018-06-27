require 'csv'

class LectorDeArchivo
  attr_reader :estados, :alfabeto, :estadoInicial, :estadosFinales, :funcionesDelta

  def initialize(archivoDescriptor)
    @archivoDescriptor = archivoDescriptor
  end

  def analizarArchivo
    automata = CSV.read(@archivoDescriptor)
    @estados = automata[0].dup
    @alfabeto = automata[1].dup
    @estadoInicial = automata[2]
    @estadosFinales = automata[3].dup

    @funcionesDelta = Array.new

    for array in 4..automata.length-1
      @funcionesDelta << automata[array]
    end
  end
end
