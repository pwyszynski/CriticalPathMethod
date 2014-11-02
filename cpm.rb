require 'graph'

class Node <
	Struct.new(:index, :czas, :poprzednik, :est, :eet)

	def print_node
		puts "#{index}\t | #{czas}\t | #{poprzednik}   \t | #{est}\t | #{eet}\t"
	end
end


graf = Array.new

# puts "Podaj liczbę węzłów:" 
# n = gets.chomp.to_i


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

#Hardcoded input:
graf.push(Node.new(1, 3, "".split(' ').map(&:to_i)))
graf.push(Node.new(2, 1, "1".split(' ').map(&:to_i)))
graf.push(Node.new(3, 4, "1".split(' ').map(&:to_i)))
graf.push(Node.new(4, 1, "2 3".split(' ').map(&:to_i)))
graf.push(Node.new(5, 9, "4".split(' ').map(&:to_i)))
graf.push(Node.new(6, 5, "4".split(' ').map(&:to_i)))
graf.push(Node.new(7, 2, "5 6".split(' ').map(&:to_i)))


graf.sort! { |a,b| a.index <=> b.index }
# drukowanie przed wykonaniem algorytmu
# puts "Indeks\t | Czas\t | Poprzednicy \t | EST\t | EET\t"
# graf.each do |x|
# 	x.print_node
# end

numofnodes = graf.length
criticalnodes = ""

# Magic - do not touch
for i in (0...numofnodes) do
	if graf[i].poprzednik.length == 0 then
		graf[i].est = 0
		graf[i].eet = graf[i].czas
		criticalnodes = criticalnodes + "#{graf[i].index}"
	end
	if graf[i].poprzednik.length == 1 then
		poprz = graf[i].poprzednik[0].to_i
		graf[i].est = graf[poprz-1].eet
		graf[i].eet = graf[i].est + graf[i].czas
		criticalnodes = criticalnodes + "#{graf[poprz-1].index}"
	end
	if graf[i].poprzednik.length > 1 then
		dlugpoprzed = graf[i].poprzednik.length
		indmax = 0 
		for j in (0...dlugpoprzed) do
			indpom = graf[i].poprzednik[j]-1
			if graf[indpom].eet > graf[indmax].eet
				indmax = indpom
			end
		end
		graf[i].est = graf[indmax].eet
		criticalnodes = criticalnodes + "#{graf[indmax].index}"
		graf[i].eet = graf[i].est + graf[i].czas
	end
end
criticalnodes = criticalnodes + "#{numofnodes}"
criticaltime = graf.last.eet
# End of magic - feel free to touch

#Usunięcie zbędnych elementów ze stringa

puts "\n\n"

criticalnodes = criticalnodes.chars.map(&:to_i).uniq
puts "Sciezka krytyczna: #{criticalnodes}"
puts "Czas krytyczny: #{criticaltime}"
puts "\n\n"

puts "Indeks\t | Czas\t | Poprzednicy \t | EST\t | EET\t"
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