require './Estado'
module CreadorDeEstados
  def crearEstados
    @lectorDeArchivo.analizarArchivo
    @lectorDeArchivo.estados.each do |estado|
      @estados << Estado.new(estado)
    end
  end
end
