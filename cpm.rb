require 'graph'

class Node <
	Struct.new(:index, :czas, :poprzednik, :est)

	def print_node
		p "#{index} | #{czas} | #{poprzednik}"
	end
end


graf = Array.new

puts "Podaj liczbę węzłów:" 
n = gets.chomp.to_i


#Input przez usera:
# for i in (0...n) do
# 	wz = Node.new
# 	p "#{i}. indeks: "
# 	wz.index = gets.chomp
# 	p "#{i}. czas: "
# 	wz.czas = gets.chomp.to_i
# 	p "#{i}. poprzednicy: "
# 	wz.poprzednik = gets.chomp.split(' ').map(&:to_i)

# 	graf.push(wz)
# end

graf.push(Node.new(1, 3, "".split(' ').map(&:to_i))
graf.push(Node.new(2, 1, "1".split(' ').map(&:to_i))
graf.push(Node.new(3, 4, "1".split(' ').map(&:to_i))
graf.push(Node.new(4, 1, "2 3".split(' ').map(&:to_i))
graf.push(Node.new(5, 9, "4".split(' ').map(&:to_i))
graf.push(Node.new(6, 5, "4".split(' ').map(&:to_i))
graf.push(Node.new(7, 2, "5 6".split(' ').map(&:to_i))


graf.sort! { |a,b| a.index <=> b.index }
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