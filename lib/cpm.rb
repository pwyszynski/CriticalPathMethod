#Useless, because graphing is not yet implemented
#require 'graph'

class Node <
	Struct.new(:index, :czas, :poprzednik, :est, :eet)

	#Printing node in preformatted table
	def print_node
		puts "#{index}\t | #{czas}\t | #{poprzednik}   \t | #{est}\t | #{eet}\t"
	end
end

#Create new array
graf = Array.new

## User input (commented out for testing)
# puts "Podaj liczbę węzłów:" 
# n = gets.chomp.to_i

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

## End of user input

#Hardcoded input:
graf.push(Node.new(1, 3, "".split(' ').map(&:to_i)))
graf.push(Node.new(2, 1, "1".split(' ').map(&:to_i)))
graf.push(Node.new(3, 4, "1".split(' ').map(&:to_i)))
graf.push(Node.new(4, 1, "2 3".split(' ').map(&:to_i)))
graf.push(Node.new(5, 9, "4".split(' ').map(&:to_i)))
graf.push(Node.new(6, 5, "4".split(' ').map(&:to_i)))
graf.push(Node.new(7, 2, "5 6".split(' ').map(&:to_i)))
#End of hardcoded input

#Sortowanie grafu
graf.sort! { |a,b| a.index <=> b.index }

# Printing before algorithm runs
# puts "Indeks\t | Czas\t | Poprzednicy \t | EST\t | EET\t"
# graf.each do |x|
# 	x.print_node
# end

#Number of nodes for loops
numofnodes = graf.length

# Checking for cycled graphs
for i in (0...graf.length) do
	dlpoprzed = graf[i].poprzednik.length
	for j in (0...dlpoprzed) do
		if graf[i].index <= graf[i].poprzednik[j] then
			puts "Podany graf jest cykliczny. Wychodzę z programu."
			exit
		end
	end
end

#Empty string for nodes on critical path
criticalnodes = ""

# --------- Magic - do not touch
for i in (0...numofnodes) do
	# If there are no predecessors (starting node):
	if graf[i].poprzednik.length == 0 then
		graf[i].est = 0
		graf[i].eet = graf[i].czas
		criticalnodes = criticalnodes + "#{graf[i].index}"
	end
	# If there is only one predecessor (nothing to compare):
	if graf[i].poprzednik.length == 1 then
		poprz = graf[i].poprzednik[0].to_i
		graf[i].est = graf[poprz-1].eet
		graf[i].eet = graf[i].est + graf[i].czas
		criticalnodes = criticalnodes + "#{graf[poprz-1].index}"
	end
	# If there are more than one predecessor (find highest EET of predecessors):
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
# --------- End of magic - feel free to touch

# Add last node to the critical nodes list:
criticalnodes = criticalnodes + "#{numofnodes}"

# Get the latest node's EET 
criticaltime = graf.last.eet


# Leave only unique nodes in an array of integers
criticalnodes = criticalnodes.chars.map(&:to_i).uniq

# Print everything useful
puts "Sciezka krytyczna: #{criticalnodes}"
puts "Czas krytyczny: #{criticaltime}"
puts "\n\n"

puts "Indeks\t | Czas\t | Poprzednicy \t | EST\t | EET\t"
graf.each do |x|
	x.print_node
end