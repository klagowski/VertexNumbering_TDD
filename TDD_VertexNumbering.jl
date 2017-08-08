include("Algorithm_NumberingVertex.jl")

using FactCheck

# TEST_1 - Usuniecie sciezek do wierzcholka - DeletePathFromGraph
# Grafy testowe
a = [false false false; false false false; false false false]
b = [true true true; true true true; true true true]
c = [false true true; false false true; false false false]
d = [true true true; false false false; true true true]
V = 2 #wierzcholek nr 2

facts("Test 1 - Usuniecie sciezki do wierzcholka") do
    @fact DeletePathFromGraph(a, V) == [false false false; false false false; false false false] --> true
    @fact DeletePathFromGraph(b, V) == [true false true; false false false; true false true] --> true
    @fact DeletePathFromGraph(c, V) == [false false true; false false false; false false false] --> true
    @fact DeletePathFromGraph(d, V) == [true false true; false false false; true false true] --> true
end

# TEST_2 - Sprawdzenie czy graf jest skierowany - IsDirectedGraph
# Grafy testowe
a = [false false false; false false false; false false false]
b = [true true true; true true true; true true true]
c = [false true true; false false true; false false false]
d = [true true true; false false false; true true true]

facts("Test 2 - Sprawdzenie czy graf jest skierowany") do
    @fact IsDirectedGraph(a) == true --> true
    @fact IsDirectedGraph(b) == false --> true
    @fact IsDirectedGraph(c) == true --> true
    @fact IsDirectedGraph(d) == false --> true
end

# TEST_3 - Sprawdzenie czy graf jest spojny - IsConnectedGraph
# Grafy testowe
a = [false false false; false false false; false false false]
b = [true true true; true true true; true true true]
c = [false true true; false false true; false false false]
d = [true true true; false false false; true true true]

facts("Test 3 - Sprawdzenie czy graf jest spojny") do
    @fact IsConnectedGraph(a) == false --> true
    @fact IsConnectedGraph(b) == true --> true
    @fact IsConnectedGraph(c) == true --> true
    @fact IsConnectedGraph(d) == true --> true
end

# TEST_4 - Sprawdzenie czy graf jest cykliczny - IsCyclicGraph
# Grafy testowe
a = [false false false; false false false; false false false]
b = [true true true; true true true; true true true]
c = [false true true; false false true; false false false]
d = [true true true; false false false; true true true]

facts("Test 4 - Sprawdzenie czy graf jest cykliczny") do
    @fact IsCyclicGraph(a) == false --> true
    @fact IsCyclicGraph(b) == true --> true
    @fact IsCyclicGraph(c) == false --> true
    @fact IsCyclicGraph(d) == true --> true
end

# TEST_5 - Algorytm Ujscie - FindVertexExit
# Grafy testowe
a = [false false false; false false false; false false false]
b = [true true true; true true true; true true true]
c = [false true true; false false true; false false false]
d = [true true true; false false false; true true true]

facts("Test 5 - Algorytm Ujscie - znalezienie wierzcholka 'UJŚCIE'") do
    @fact FindVertexExit(a) == 1 --> true
    @fact FindVertexExit(b) == nothing --> true
    @fact FindVertexExit(c) == 3 --> true
    @fact FindVertexExit(d) == 2 --> true
end

# TEST_6 - Usuniecie wierzcholka Ujscie - DeleteVertexFromGraph
# Grafy testowe
a = [false false false; false false false; false false false]
b = [true true true; true true true; true true true]
c = [false true true; false false true; false false false]
d = [true true true; false false false; true true true]
V = 2 #Wierzcholek nr 2

facts("Test 6 - Usuniecie wierzcholka 'UJŚCIE'") do
    @fact DeleteVertexFromGraph(a, V) == [false false; false false] --> true
    @fact DeleteVertexFromGraph(b, V) == [true true; true true] --> true
    @fact DeleteVertexFromGraph(c, V) == [false true; false false] --> true
    @fact DeleteVertexFromGraph(d, V) == [true true; true true] --> true
end

# TEST_7 - Uzupełnienie zerami tablicy  przechowujacej ponumerowane wierzcholki - DeleteVertexFromGraph
# Grafy testowe
a = [false false false; false false false; false false false]
b = [true true ; true true]
c = [false]
d = [true true true true true; false false false false false; true true false false true; true true false false true; true true false false true]

facts("Test 7 - Uzupełnienie zerami tablicy") do
    @fact ResetVertexOrder(a) == [0, 0, 0] --> true
    @fact ResetVertexOrder(b) == [0, 0] --> true
    @fact ResetVertexOrder(c) == [0] --> true
    @fact ResetVertexOrder(d) == [0, 0, 0, 0, 0] --> true
end


# TEST_8 - Algorytm Numerowanie Wierzcholkow  - NumberingVertexAlgorytm
# Grafy testowe
a = [false false; true false]
b = [false false false false true false true; false false false false false false true; false true false false true false true; true false true false false true true; false true false false false false true; false false true false false false false; false false false false false false false]
c = [false false false false; false false false false; true true false false; false false true false]
d = [false false false false true; false false false false true; true true false false true; false true false false true; false false false false false]

facts("Test 8 - Algorytm Numerowanie Wierzcholkow") do
    @fact NumberingVertexAlgorytm(a) == [1,2] --> true
    @fact NumberingVertexAlgorytm(b) == [4,2,5,7,3,6,1] --> true
    @fact NumberingVertexAlgorytm(c) == [1,2,3,4] --> true
    @fact NumberingVertexAlgorytm(d) == [2,3,4,5,1] --> true
end
