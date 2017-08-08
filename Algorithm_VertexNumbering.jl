
#Wybor opcji z menu
function choosenOptionStart(n)
  if n == "1"
    InsertGraph()
  elseif n == "2"
    GenerateGraph()
  elseif n == "3"
    PrintGraph(GraphArray, VertexOrder)
  elseif n == "4"
    NumberingVertexAlgorytm(GraphArray)
  else
    println("Wybierz dostępną opcję!")
  end
end

#Drukowanie MENU
function printMenu()
  println("MENU")
  println("1. Wprowadź graf skierowany acykliczny")
  println("2. Wygeneruj graf")
  println("3. Zaprezentuj graf")
  println("4. Numeruj wierzchołki")
  println("5. Exit")
end

#Drukowanie grafu
function PrintGraph(_GraphArray, _VertexOrder)
  for i in 1:1:size(_GraphArray,1)
    if i == 1
      for z in 1:1:size(_GraphArray,1)
        if z == 1
          print("     $z")
        else
          print("      $z")
        end
      end
      print("    |  Nr V.")
      println("")
    end
    for j in 1:1:size(_GraphArray,1)
      if j == 1
        print("$i  ")
      end
        print(_GraphArray[i,j])
        if _GraphArray[i,j] == true
          print("   ")
        else
          print("  ")
        end
    end
    print("|  ")
    print(_VertexOrder[i])
    println("")
  end
end

#Funkcja sprawdza czy graf jest skierowany
function IsDirectedGraph(_GraphArray)
  for i in 1:1:size(_GraphArray,1)
    for j in 1:1:size(_GraphArray,1)
      if _GraphArray[i,j] == true && _GraphArray[j,i] == true
        return false
      end
    end
  end
  return true
end

#Funkcja sprawdza czy graf jest spojny
function IsConnectedGraph(_GraphArray)
  #i = FindVertexExit(_GraphArray)
  for i in 1:1:size(_GraphArray,1)
    if true  in  _GraphArray[i,:]
    else
      if true  in  _GraphArray[:,i]
      else
        return false
      end
    end
  end
  return true
end

#Funkcja sprawdza czy graf jest cykliczny
function IsCyclicGraph(_GraphArray)
  CopyGraphArray = _GraphArray
  for i in 1:1:size(_GraphArray,1)
    VertexExit = FindVertexExit(CopyGraphArray)
    if VertexExit != nothing
    CopyGraphArray = DeleteVertexFromGraph(CopyGraphArray, VertexExit)
    else
      return true
    end
  end
  return false
end

#Usuniecie wierzcholka Ujscie
function DeleteVertexFromGraph(_GraphArray, _ExitVertex)
  _GraphArray = _GraphArray[1:end .!= _ExitVertex, :]
  _GraphArray = _GraphArray[:, 1:end .!= _ExitVertex]
  return _GraphArray
end

#Usuniecie sciezki do wierzcholka
function DeletePathFromGraph(_GraphArray, _ExitVertex)
  _GraphArray[1:end, _ExitVertex] = false
  _GraphArray[_ExitVertex, 1:end] = false
  return _GraphArray
end

#Algorytm Ujscie v0
function FindVertexExit(_GraphArray)
  for i in 1:1:size(_GraphArray,1)
    if true  in  _GraphArray[i,:]
    else
      return i
    end
  end
end

#Algorytm Ujscie v1
function FindNextVertexExit(_GraphArray, _FindedVertexExit)
  for i in 1:1:size(_GraphArray,1)
    if true  in _GraphArray[i,:]
    else
      if i in  _FindedVertexExit[:]
      else
        return i
      end
    end
  end
end

#Uzupełnienie zerami tablicy  przechowujacej ponumerowane wierzcholki
function ResetVertexOrder(_GraphArray)
  return global VertexOrder = fill(0,size(_GraphArray,1))
end

#Generowanie losowego grafu skierowanego acyklicznego spojnego
function GenerateGraph()
  IsGraphCorrect = false
  V = rand(2:7)
  while !IsGraphCorrect
    global GraphArray = bitrand(V,V)
    if IsConnectedGraph(GraphArray) && IsDirectedGraph(GraphArray) && !IsCyclicGraph(GraphArray)
      IsGraphCorrect = true
    end
  end
  ResetVertexOrder(GraphArray)
  return GraphArray
end

#####################################################
######    Algorytm Numerowanie Wierzcholkow    ######
#####################################################
function NumberingVertexAlgorytm(_GraphArray)
  #Tworzenie kopii grafu
  CopyGraphArray = copy(_GraphArray)
  #Tworzenie tabeli lokalnej przechowujacej znalezione UJSCIA grafu
  FindedVertexExit = fill(0,size(_GraphArray,1))
  #Tworzenie tabeli globalnej przechowujacej ponumerowane wierzcholki
  ResetVertexOrder(_GraphArray)
  #Przeszukiwanie wezlow grafu w petli for
  for i in 1:1:size(_GraphArray,1)
    #Szukanie wezla grafu "UJSCIE"
    VertexExit = FindNextVertexExit(CopyGraphArray, FindedVertexExit)
    #Usuniecie wezla "UJSCIE" z grafu
    FindedVertexExit[i] = VertexExit
    #Usuniecie sciezek do wezla "UJSCIE"
    CopyGraphArray = DeletePathFromGraph(CopyGraphArray, VertexExit)
    #Przypisanie numeru wezla i zapisanie do tabeli globalnej przechowujacej ponumerowane wierzcholki
    VertexOrder[VertexExit] = i
  end
return VertexOrder
end

#Wprowadzanie grafu zdefiniowanego przez uzytkownika
function InsertGraph()
    println("Wprowadź ilość wierzchołkow: ")
    V = parse(Int8, chomp(input()))
    global GraphArray = BitArray(V,V)
    for i in 1:1:size(GraphArray,1)
      for j in 1:1:size(GraphArray,1)
        if i!=j && GraphArray[j,i]!=true
          println("Czy istnieje krawędz $i -> $j (Y/N):")
          inputUser = lowercase(chomp(input()))
          while (inputUser != "y" && inputUser != "n")
            println("Wpisz Y/N:")
            inputUser = lowercase(chomp(input()))
          end
          if inputUser == "y"
            GraphArray[i,j] = true
          end
        end
      end
    end
    ResetVertexOrder(GraphArray)
end

#Nadanie wartosci poczatkowych zmiennym globalnych
function init()
  global VertexOrder = fill(0,3) #Kolejnosc wierzcholkow
  global GraphArray = BitArray(3,3) #Reprezentacja grafu przez macierz sąsiedztwa
end

#Petla programu
function programLoop()
  init()
  n = 0
  while n !="5"
  printMenu()
  sleep(0.2)
  n = chomp(input())
  choosenOptionStart(n)
  end
end

#Uruchomienie programu
programLoop()
