require 'thread'

class Produtor

  attr_accessor :thread

  def initialize(fila)
    @fila = fila
    @thread = Thread.new { run}
  end

  def run
    5.times do
      i = rand(1..1000)
      puts "Produzido #{i}"

      @fila << i
      sleep(2)
    end
  end

  def join
    @thread.join
  end
end

class Consumidor
  def initialize(fila, targetedThread)
    @fila = fila
    @thread = Thread.new {run}
    @targetedThread = targetedThread
  end

  def run
    while @targetedThread.alive?
      elemento = @fila.pop
      puts "Este #{elemento} foi consumido"
    end
  end

  def join
    @thread.join
  end
end

if __FILE__ == $0
  fila = Queue.new
  produtor = Produtor.new(fila)
  consumidor = Consumidor.new(fila, produtor.thread)  

  
  produtor.join

end
