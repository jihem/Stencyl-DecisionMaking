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

To help me to continue this job and add more samples, please make a donation. For 10 euros,I will reward you with dm-astar-5 and 6 samples (not available for download here). If you want to do it yourself and don't need samples, you can use the new block "set cooperative paths list" provided. The Stencyl extension is still up to date. If you are using this in a game (and earn money), please give a minimal amount of 20 euros (I won't check but without your support I can't continue). Make it the way you feel good... Even using it for free, if you think I'm that bad.

<form action="https://www.paypal.com/cgi-bin/webscr" method="post">
<input type="hidden" name="cmd" value="_s-xclick">
<input type="hidden" name="encrypted" value="-----BEGIN PKCS7-----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-----END PKCS7-----
">
<input type="image" src="https://www.paypalobjects.com/fr_XC/i/btn/btn_donateCC_LG.gif" border="0" name="submit" alt="PayPal - la solution de paiement en ligne la plus simple et la plus sécurisée !">
<img alt="" border="0" src="https://www.paypalobjects.com/fr_FR/i/scr/pixel.gif" width="1" height="1">
</form>

