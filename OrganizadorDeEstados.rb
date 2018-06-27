require './LectorDeArchivo'
module OrganizadorDeEstados
  def asignarTransiciones
    #Por cada estado, en su arreglo "transiciones" le inserta X+1 arreglos
    #siendo X el número de símbolos en nuestro alfabeto y el +1 representando
    #la transición Epsilon puesto que no está dentro del alfabeto
    @estados.each do |estado|
      for n in 0..@lectorDeArchivo.alfabeto.length
        estado.transiciones << Array.new
      end
    end
    estadoOrigen = nil
    @lectorDeArchivo.funcionesDelta.each do |funcion|
      #funcion[0] es el estado origen
      #funcion[1] es la trancisión
      #funcion[2] es el estado destino
      estadoOrigenIndex = @estados.index {|estado| estado.estadoID == funcion[0]}

      if funcion[1] == "E"
        renglon =  @lectorDeArchivo.alfabeto.length
      else
        renglon =  @lectorDeArchivo.alfabeto.index{|letra| letra == funcion[1]}
      end

      @estados[estadoOrigenIndex].transiciones[renglon] << funcion[2]
    end
  end
end
