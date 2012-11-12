/*
Extend (A* sample and DecisionMaking extension) CC-BY  Jean-Marc "jihem" QUERE - whizkids.fr 2012 
*/

import com.stencyl.Engine;

class DecisionMaking
{
	public static function getAStarMap(layerID:Int,tileCD:String):String
	{
		return AStar.getMap(layerID,tileCD).join("|");
	}

	public static function getAStarPath(map:String,fx:Int,fy:Int,tx:Int,ty:Int,dg:Int):String
	{
		return new AStar(map).from(fx,fy).to(tx,ty,dg).path();
	}

	public static function setAStarCost(s:String,c:Float)
	{
		AStar.setCost(s,c);
	}

	public static function getAStarCost(map:String,pth:String):Float
	{
		return new AStar(map).getPathCost(pth);
	}
}

class ANode
{
	public var x:Int;
	public var y:Int;
	public var h:Float;
	public var c:Float;
	public var p:List<ANode>;

	public function new(x:Int=0,y:Int=0,h:Float=0,c:Float=0)
	{
		this.x=x;
		this.y=y;
		this.h=h;
		this.p=new List<ANode>();
	}

	public function equals(o:ANode):Bool
	{
		return this.x==o.x && this.y==o.y;
	}
}

class AStar
{

	var map:Array<String>;
	static var cst:Hash<Float>;
	var mxx:Int;
	var mxy:Int;
	var opn:List<ANode>; 
	var cld:List<ANode>;
	var pth:List<ANode>;

	public static function getMap(layerID:Int,tileCD:String):Array<String>
	{
		var map=new Array<String>();
		var row;
		var engine=Engine.engine;
		var layer = engine.tileLayers.get(layerID);
		for (vy in 0...Std.int(engine.scene.sceneHeight/engine.scene.tileHeight))
		{
			row="";
			for (vx in 0...Std.int(engine.scene.sceneWidth/engine.scene.tileWidth))
			{
				var tile=layer.getTileAt(vy, vx);
				if (tile!=null)
				{
					row+=tileCD.substr(tile.tileID,1);
				}
				else
					row+="X";
			}
			map.push(row);
		}
		return map;
	}

	public static function setCost(s:String,c:Float)
	{
		if (AStar.cst==null) 
		{
			AStar.cst=new Hash<Float>();
		}
		AStar.cst.set(s,c);
	}

	public function new(smap:String)
	{
		if (AStar.cst==null) 
		{
			AStar.cst=new Hash<Float>();
			AStar.setCost(".",0);
		}
		this.map=smap.split("|");
		this.mxx=map[0].length;
		this.mxy=map.length;
		this.opn=new List<ANode>();
		this.cld=new List<ANode>();
	}

	public function get(x:Int,y:Int):String
	{
		return this.map[y].substr(x,1);
	}

	public function from(x:Int,y:Int):AStar
	{
		opn.clear();
		opn.add(new ANode(x,y));
		cld.clear();
		return this;
	}

	public function popHmin():ANode
	{
		var h:Float= Math.POSITIVE_INFINITY;
		var o:ANode=new ANode();
		for (i in opn) 
		{
			if (i.h<h)
			{
				h=i.h;
				o=i;
			}
		}
		opn.remove(o);
		return o;
	}

	public function to(x:Int,y:Int,dg:Int=0):AStar
	{
		var it=dg==1?[{dx:-1,dy:-1},{dx:0,dy:-1},{dx:1,dy:-1},{dx:-1,dy:0},{dx:1,dy:0},{dx:-1,dy:1},{dx:0,dy:1},{dx:1,dy:1}]:[{dx:0,dy:-1},{dx:-1,dy:0},{dx:1,dy:0},{dx:0,dy:1}];
		var vt=new ANode(x,y);
		pth=null;
		while (! opn.isEmpty())
		{
			var o=popHmin();
			cld.add(o);
			for (i in it)
			{
				var vx=o.x+i.dx;
				var vy=o.y+i.dy;
				if (pth==null)
					if (vx==x && vy==y)
					{
						pth=o.p;
						pth.add(new ANode(x,y));
						opn.clear();
					}
					else
						if (vx>-1 && vy>-1 && vx<=this.mxx && vy<=this.mxy)
						{
							var id=get(vx,vy);
							if (AStar.cst.exists(id))
							{
								var vo=new ANode(vx,vy);
								if ((this.cld.filter(vo.equals).length==0) &&
								    (this.opn.filter(vo.equals).length==0))
								{
									vo.h=Math.abs(vo.x-vt.x)+Math.abs(vo.y-vt.y)+AStar.cst.get(id);
									vo.p=new List<ANode>();
									for (i in o.p)
										vo.p.add(i);
									vo.p.add(vo);
									opn.add(vo);
								}
							}
						}
			}
		}
		cld.clear();
		return this;
	}

	public function path():String
	{
		var pth="";
		if (this.pth!=null)
			for (i in this.pth)
			{
				pth+="|"+i.x+","+i.y;
			}
		return pth.substr(1);
	}

	public function getPathCost(spth:String):Float
	{
		var cst:Float=0;
		var pth:Array<String>;
		pth=spth.split("|");
		for (i in pth)
		{
			var xy=i.split(",");
			cst+=AStar.cst.get(get(Std.parseInt(xy[0]),Std.parseInt(xy[1])));
		}
		return cst;
	}
}