# MazeGenerator7800
This is a demo game for the Atari 7800 that creates a random maze using the binary tree algorithm.

Development Thread:  https://forums.atariage.com/topic/269508-7800-random-maze-generator/#comment-3838857

<img><img src="https://github.com/AtariusMaximus/MazeGenerator7800/blob/main/MazeGenerator_screenshot1.png">

This is a random maze generator for the 7800. I wrote this out of personal interest and didn't actually have a game in mind for it, but it could certainly be adapted into a game. I wrote this using the binary tree maze creation algorithm, which is fairly simple. Each block in the maze is checked for an opening in two adjacent directions (in this case south and west), and if no openings exist one is created. If an opening already exists in either direction the block is skipped. The maze is 25x25, but could be made larger. 

There is a simple title screen that is necessary in order to properly seed the randomizer before maze creation begins. I created custom image files, you'll need to download them if you'd like to compile this yourself.
