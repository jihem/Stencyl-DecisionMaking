Stencyl-DecisionMaking
======================

Stencyl extension about decision making algorithms (A*,...)

**AStar**

![tileset](/jihem/Stencyl-DecisionMaking/blob/master/doc/tileset.png?raw=true)

You need to build a tileset. It can be the main tileset (to design the scene) of a dedicated tileset (on another layer, not visible). Each tile can be a path (.) or a wall (X). In this sample, I choose to use A1 and C1 as path tiles and B1, D1, E1 as wall tiles. E1 isn't used : I put the actor in the same bitmap. The code for this tileset is : .X.XX (see map for... block).

![mapfor](/jihem/Stencyl-DecisionMaking/blob/master/doc/mapfor.png?raw=true)

The "map for..." block build a coded representation of a scene. The representation for the scene below is : "XXXXX.....|X.........|X.........|X...X.....|X...X..XXX|X........X|X........X|XXXXXXX..X|.........X|.........X|....XXXXXX|....X.....|....X.....|..........|..........".

![scene](/jihem/Stencyl-DecisionMaking/blob/master/doc/scene.png?raw=true)

Now you can use the coded representation to ask for the way from a position (ie. row:1,col:1) to a destination (row:11,col:5). The "path for..." block can return 2 responses (with or without using diagonals).

With : 2,2|3,3|3,4|4,5|5,6|6,6|7,7|6,8|5,9|4,9|3,10|3,11|3,12|4,13|5,12|5,11

Without : 2,1|3,1|4,1|5,1|5,2|5,3|5,4|5,5|5,6|6,6|7,6|7,7|7,8|6,8|5,8|5,9|4,9|3,9|3,10|3,11|3,12|3,13|4,13|5,13|5,12|5,11

![pathfor](/jihem/Stencyl-DecisionMaking/blob/master/doc/pathfor.png?raw=true)

In the scene, some B1 tiles can be added and used as a difficult path with a cost of (5, 1 is the cost of the travel from a tile to the next tile in the row). The "map for..." block use the code ".A.XX" (B1 isn't a wall). The "setcodecost" set the cost of the "A" tiles.

![setcost](/jihem/Stencyl-DecisionMaking/blob/master/doc/setcost.png?raw=true)

The "path for..." block find the best way (at the lowest cost). It will tries to avoid the A tiles.

You can get the cost of the path with the block "cost for map...". For the map parameter, you can use a stored "map for..." representation. The path argument needs a "path for..." result. If you set the cost of the dot (.) to 1, you will get the count of used tiles in this sample.

![costformap](/jihem/Stencyl-DecisionMaking/blob/master/doc/costformap.png?raw=true)


Need more ? Go to [whizkids.fr](http://whizkids.fr)

Note:

The dm-astar-1.stencyl is a "game" ready to import in Stencyl (3). So you can play with this extension (without having to spend time building a test project).

- dm-astar-1 : basic path finding

- dm-astar-2 : eval path cost

- dm-astar-3 : hunters chase a target (no collision)

- dm-astar-4 : hunters chase a target (with physics and collision)

The samples 3 and 4 have been brought to you by Tom Vencel (http://ninjadoodle.com). He made a donation for this on my paypal account. It's very kind to support me.

![new](/jihem/Stencyl-DecisionMaking/blob/master/doc/new.png?raw=true)

AStar implementation introduces a new Stencyl block : "set cooperative path lists ...".  It's used to declare a list of paths. So each actor can avoid the position of the others actors while trying to find its own way. All the actors who work together have to put their path in this list (and reset it before the search => otherwise it will try to avoid itself…). The most difficult part is to play the journey. The actors need to stay synchronized (they will update their way only if the target move).

![setcooperativepathslist](/jihem/Stencyl-DecisionMaking/blob/master/doc/setcooperativepathslist.png?raw=true)

The following samples introduce cooperative path finding (with and without )

- dm-astar-5 : hunters chase a target (cooperative path finding => reserves all the tiles used by each way)

- dm-astar-6 : hunters chase a target (cooperative path finding => use "set cooperative path lists" to limit reservation of each tile used at a given time (tri-dimensional slice x,y,t).

To help me to continue this job and add more samples, please make a donation (send money using https://www.paypal.com to quere.jmarc(at)free.fr => replace (at) with @). For 10 euros,I will reward you with dm-astar-5 and 6 samples (not available to download here). If you want to do it yourself and don't need samples, you can use the new block "set cooperative paths list" provided. The Stencyl extension is still up to date. If you are using this in a game (and earn money), please give a minimal amount of 20 euros (I won't check but without your support I can't continue). Make it the way you feel good... Even using it for free, if you think I'm that bad.

Screen capture of [dm-astar-6](http://youtu.be/-QsCyc02LQc)...
