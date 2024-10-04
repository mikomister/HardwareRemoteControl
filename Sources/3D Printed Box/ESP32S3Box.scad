include <lib/helpers.scad>
include <lib/corners.scad>

PreviewCap = false;

RelaysCount = 4;
RelayOutCableDiameter = 2;

Over = 0.01;
FN = ($preview ? 64 : 256);

PlugTypeCWidth = 8.8;
PlugTypeCHeight = 3.3;

PlugsDistance = 2.9;
BoardWidth = 28.4;
BoardLength = 63.5;
BoardHeight = 5;
PlugTypeCTop = 1.6;

RelayWidth = 10.7; //!!!
RelayLength = 15.7; //!!!
RelayHeight = 18; //!!!
RelayCableThick = 4;

WallsThick = 1.8;
CapThick = 2.4;
FanBoltLength = getFanBoltLength() - CapThick + 0.4;

_Height1 = (RelayHeight + WallsThick > FanBoltLength && RelaysCount > 0 ? RelayHeight + WallsThick : FanBoltLength);
_Height2 = (BoardHeight + WallsThick > _Height1 ? BoardHeight + WallsThick : _Height1);
MinHeight = _Height2;


Round = 4;

_Width1 = (RelayWidth > getFanBoltDiameter() && RelaysCount > 0 ? RelayWidth : getFanBoltDiameter());
AdvWidth = _Width1 + WallsThick;

BoxWidth = BoardWidth + AdvWidth * 2 + WallsThick * 2;
BoxHeight = MinHeight;
BoxLength = BoardLength + WallsThick * 2;


difference() {
	union() {
		difference() {
			cuberounded([BoxWidth, BoxLength, BoxHeight], [1,2,3,4], radius = Round, fn = FN); //Main Box
			right(WallsThick + AdvWidth) out(WallsThick) up(WallsThick) cube([BoardWidth, BoardLength, BoxHeight]); //Board Space
			
			//TypeC
			right(WallsThick + AdvWidth) in(Over) up(WallsThick + PlugTypeCTop + PlugTypeCHeight / 2) right(BoardWidth / 2) 
			for (i = [-1, 1]) {
				right(i * (PlugsDistance / 2 + PlugTypeCWidth / 2)) rotate([-90, 0, 0]) hull() {
					for (j = [-1, 1]) right((PlugTypeCWidth / 2 - PlugTypeCHeight / 2) * j) cylinder(h = WallsThick + Over * 2, d1 = PlugTypeCHeight /** 2*/, d2 = PlugTypeCHeight, $fn = FN);
				}
			}
			
			//Relays
			right(BoxWidth / 2) up(BoxHeight - RelayHeight) out(WallsThick * 3 +  getFanBoltDiameter())
			for (i = [0 : RelaysCount - 1]) {
				xq = (i % 2 == 0 ? 1 : -1);
				out(floor(i / 2) * (RelayLength + WallsThick))
				left((BoxWidth / 2 - RelayWidth / 2 - WallsThick) * xq) left(RelayWidth / 2) {
					cube([RelayWidth, RelayLength, RelayHeight + Over]);
					up(RelayHeight - RelayCableThick) right((WallsThick + Over) * xq) cube([RelayWidth, RelayLength, RelayHeight + Over]);
				}
			}
			
			//Relays Cables
			if (RelaysCount > 0) {
				TotalCableWidth = RelayOutCableDiameter * RelaysCount;
				right(BoxWidth / 2) up(BoxHeight) in(Over) rotate([-90, 0, 0])
				hull() {
					for (i = [-1, 1]) {
						left((TotalCableWidth - RelayOutCableDiameter / 2) / 2 * i) cylinder(h = WallsThick + Over * 2, d = RelayOutCableDiameter * 2, $fn = FN);
					}
				}
			}
		}
		
		if (!$preview || PreviewCap) {
			up(BoxHeight + Over) cuberounded([BoxWidth, BoxLength, CapThick], [1,2,3,4], radius = Round, fn = FN); //Box Cap
		}
	}
	//Bolts holes
	right(BoxWidth / 2) out(BoxLength / 2) up(BoxHeight + CapThick + Over * 2)
	for (i = [-1, 1]) {
		out(i * (BoxLength / 2 - getFanBoltDiameter() / 2 - WallsThick * 2))
		for (j = [-1, 1]) {
			left(j * (BoxWidth / 2 - getFanBoltDiameter() / 2 - WallsThick * 2))
			fanBolt(true);
		}
	}
}