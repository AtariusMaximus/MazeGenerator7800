  rem ** Maze Generator
  rem ** Binary Tree Algorithm Demo
  rem ** Steve Engelhardt
  rem ** 8/31/2017
  
  set zoneheight 8
  set screenheight 224

  displaymode 160A

  incgraphic tileset_mazegen.png 160A
  incgraphic alphabet_mazegen.png 160A
  incgraphic tileset_mazedigits.png 160A

  dim MoveX=x 
  dim MoveY=y 
  dim ValueS=a 
  dim ValueW=b 
  dim CheckS=c
  dim CheckW=d 
  dim RandGen=e 
  dim RandomSeed=f
  dim MazeFinished=g

  P0C1=$72
  P0C2=$70
  P0C3=$76
  P1C1=$92
  P1C2=$92
  P1C3=$92
  P2C1=$70
  P2C2=$70
  P2C3=$82
  P3C1=$70
  P3C2=$70
  P3C3=$70

  dim screendata=$2200 
  dim screendata2=$2472
  dim screendata3=$25D1
  dim screendata4=$25F2

  characterset alphabet_mazegen
  MoveX=0:MoveY=0

  rem ** Titlescreen
  rem ** Note that the titlescreen sets the random seed for the Maze
  rem ** and requires the random human input timing of starting 
  rem ** to actually randomize the maze
start
  clearscreen
  plotchars 'maze generator' 0 42 8
  plotchars 'press fire to start' 0 32 20
  savescreen
startloop
  restorescreen
  RandomSeed=RandomSeed+1
  if RandomSeed>64 then RandomSeed=1
  if joy0fire then rand=RandomSeed:goto begin
  drawscreen
  goto startloop

  rem ** Configure screen RAM 
  rem ** This section fills RAM with display characters
begin
    clearscreen
  rem ** Maze Area uses $2200-$2471
    memcpy screendata screenmap1 625
    plotmap screendata  0  0 0  25 25   
  rem ** Right Status area uses $2471-$25D0
    memcpy screendata2 screenmap2 350
    plotmap screendata2 1  104 0  14 25
  rem ** Bottom Status area uses $25D1-$25F1
    memcpy screendata3 screenmap3  32
    plotmap screendata3 2  0   25  32 1
    plotmap screendata3 2  104 25  32 1
  rem ** Bottom Right Status area uses $25F2-$2612
    memcpy screendata4 screenmap4  32
    plotmap screendata4 3  0   26  32 1
    plotmap screendata4 3  104 26  32 1
    plotmap screendata4 3  0   27  32 1
    plotmap screendata4 3  104 27  32 1
    savescreen
  
  rem ** Main Loop
  rem ** Here we check all maze characters in RAM in a 25x25 grid
  rem ** using the Binary Tree algorithm. Each character is analyzed
  rem ** by checking the blocks directly to the south and the west.
  rem ** if one of them already has an opening, the block is skipped.
  rem ** if there are no openings to the south or west, one block
  rem ** is randomly cleared, and we move on to the next.
main 
  characterset alphabet_mazegen
mainloop
  RandomSeed=RandomSeed+1
  if RandomSeed>64 then RandomSeed=1
  drawwait
   RandGen=rand
   if MoveX>25 then MoveX=1
   if MoveY>23 then MazeFinished=1:goto skipGen
   gosub checkSouth
   gosub checkWest
   gosub mazeGen 
   MoveX=MoveX+1
   if MoveX=25 && MoveY<24 then MoveY=MoveY+1
skipGen
   drawscreen
   if MazeFinished=1 then goto mazeComplete
   goto mainloop 

  rem ** Here we check the block immediately to the south of the selected block
  rem ** If the block is open, the ValueS flag is set to 1.
checkSouth
   CheckS=MoveY+1
   if peekchar(screendata,MoveX,CheckS,25,25)<>1 then ValueS=1 
   if peekchar(screendata,MoveX,CheckS,25,25)=1 then ValueS=0
 return
   rem ** Here we check the block immediately to the west of the selected block
   rem ** If the block is open, the ValueW flag is set to 1.
checkWest
   CheckW=MoveX-1
   if peekchar(screendata,CheckW,MoveY,25,25)<>1 then ValueW=1 
   if peekchar(screendata,CheckW,MoveY,25,25)=1 then ValueW=0
 return

   rem ** Clear blocks in the Maze
   rem ** if neither of the check flags is set to 1, we do nothing and return.
   rem ** if one of them is set to 1, we randomly clear either a south or west block.
mazeGen
   if ValueS=0 || ValueW=0 then MoveX=MoveX+1:return: rem * if a path is already opened either way, do nothing
   if RandGen>128 then goto OpenW
   if RandGen<129 then goto OpenS
OpenS
   pokechar screendata MoveX CheckS 25 25 1:return
   return
OpenW
   pokechar screendata CheckW MoveY 25 25 1:return
   return

  rem ** Maze Generation complete 
  rem ** we change the characterset to the alphabet, restore the saved screen, and 
  rem ** we can then plot values and characters in the status areas.
mazeComplete
  characterset alphabet_mazegen
mazeCompleteloop
  restorescreen
  drawwait
  ;plotchars 'test value' 0 104 20
  ;plotvalue tileset_mazedigits 0 MoveX 6 104 21 
  plotchars 'maze' 0 104 1:plotchars 'generator' 0 122 1
  plotchars 'binary tree' 0 104 4
  plotchars 'algorithm' 0 104 5
  plotchars 'steve' 0 104 23
  plotchars 'engelhardt' 0 104 24
  drawscreen
 goto mazeCompleteloop

  rem ** Here we set the character RAM screen map data 
  rem ** This demo uses custom image files
  alphachars ' B#i$abcdefghijklmnopqrstuvwxyz%' 

 alphadata screenmap1 tileset_mazegen
 '################################'
 '################################'
 '################################'
 '################################'
 '################################'
 '################################'
 '################################'
 '################################'
 '################################'
 '################################'
 '################################'
 '################################'
 '################################'
 '################################'
 '################################'
 '################################'
 '################################'
 '################################'
 '################################'
 '################################'
 '################################'
 '################################'
 '################################'
 '################################'
 '################################'
 '################################'
 '################################'
end

 ;alphachars ' B#i$abcdefghijklmnopqrstuvwxyz%'

 alphadata screenmap2 tileset_mazegen
 '##############'
 '##############'
 '##############'
 '##############'
 '##############'
 '##############'
 '##############'
 '##############'
 '##############'
 '##############'
 '##############'
 '##############'
 '##############'
 '##############'
 '##############'
 '##############'
 '##############'
 '##############'
 '##############'
 '##############'
 '##############'
 '##############'
 '##############'
 '##############'
 '##############'
end

 alphadata screenmap3 tileset_mazegen
 '################################'
end

 alphadata screenmap4 tileset_mazegen
 '################################'
end

