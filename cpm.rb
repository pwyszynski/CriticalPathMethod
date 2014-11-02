require 'graph'

class Node <
	Struct.new(:index, :czas, :poprzednik)

	def print_node
		p "#{index} | #{czas} | #{poprzednik}"
	end
end


graf = Array.new

puts "Podaj liczbę węzłów:" 
n = gets.chomp.to_i

for i in (0...n) do
	wz = Node.new
	p "#{i}. indeks: "
	wz.index = gets.chomp
	p "#{i}. czas: "
	wz.czas = gets.chomp.to_i
	p "#{i}. poprzednicy: "
	wz.poprzednik = gets.chomp.split(' ').map(&:to_i)

	graf.push(wz)
end

graf.each do |x|
	x.print_node
end

# digraph do
#       # many ways to access/create edges and nodes
#       edge "a", "b"
#       self["b"]["c"]
#       node("c") >> "a"

#       square   << node("a")
#       triangle << node("b")

#       red   << node("a") << edge("a", "b")
#       green << node("b") << edge("b", "c")
#       blue  << node("c") << edge("c", "a")

#       save "simple_example", "png"
# end