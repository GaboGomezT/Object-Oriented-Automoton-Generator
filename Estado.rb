class Estado
  attr_reader :estadoID, :transiciones
  attr_writer :transiciones
  
  def initialize(estadoID)
    @estadoID = estadoID
    @transiciones = Array.new
  end
  def inspect
    print "{estadoID: #{@estadoID}\nTrancisiones: "
    @transiciones.each {|renglon| puts "#{renglon}"}
    puts "}"
  end
end
