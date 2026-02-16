plen=binaryOccupancyMap(7,3,20);

%THE PLENMASTER (we got square planes before GTA 6)

WingSize=[2 0.25]; %Wing Dimensions in units of whatever
BodySize=[0.5 1.4]; %Fuselage Dimensions in units of whatever
PlaneCenter=[5 1.8]; %Location of Plane in Hangar in units of whatever

WingCenterFactor=0.5; 
%Multiplier Determining plane direction and wing location proportional to
%fuselage. Maximum recommended value is +-0.8

WingCenterOffset=WingCenterFactor*BodySize(2)*0.5;
WingCenter=[PlaneCenter(1) PlaneCenter(2)+WingCenterOffset];

wingtop = [WingCenter(1)-(WingSize(1)*0.5):0.01:WingCenter(1)+(WingSize(1)*0.5) ; WingCenter(2)+(WingSize(2)*0.5).*ones(1,length(WingCenter(1)-(WingSize(1)*0.5):0.01:WingCenter(1)+(WingSize(1)*0.5)))];
wingbot= [WingCenter(1)-(WingSize(1)*0.5):0.01:WingCenter(1)+(WingSize(1)*0.5) ; WingCenter(2)-(WingSize(2)*0.5).*ones(1,length(WingCenter(1)-(WingSize(1)*0.5):0.01:WingCenter(1)+(WingSize(1)*0.5)))];
wingl= [WingCenter(1)-(WingSize(1)*0.5).*ones(1,length(2:0.01:2.25)); WingCenter(2)-(WingSize(2)*0.5):0.01:WingCenter(2)+(WingSize(2)*0.5)];
wingr= [WingCenter(1)+(WingSize(1)*0.5).*ones(1,length(2:0.01:2.25)); WingCenter(2)-(WingSize(2)*0.5):0.01:WingCenter(2)+(WingSize(2)*0.5)];

%body
bodytop = [PlaneCenter(1)-(BodySize(1)*0.5) :0.01: PlaneCenter(1)+(BodySize(1)*0.5) ; (PlaneCenter(2)+BodySize(2)*0.5)*ones(1,length(PlaneCenter(1)-(BodySize(1)*0.5):0.01:PlaneCenter(1)+(BodySize(1)*0.5)))];
bodybot = [PlaneCenter(1)-(BodySize(1)*0.5):0.01:PlaneCenter(1)+(BodySize(1)*0.5) ; (PlaneCenter(2)-BodySize(2)*0.5)*ones(1,length(PlaneCenter(1)-(BodySize(1)*0.5):0.01:PlaneCenter(1)+(BodySize(1)*0.5)))];
bodyl = [PlaneCenter(1)-(BodySize(1)*0.5).*ones(1,length(PlaneCenter(2)-BodySize(2)*0.5:0.01:PlaneCenter(2)+BodySize(2)*0.5)); PlaneCenter(2)-BodySize(2)*0.5:0.01:PlaneCenter(2)+BodySize(2)*0.5];
bodyr = [PlaneCenter(1)+(BodySize(1)*0.5).*ones(1,length(PlaneCenter(2)-BodySize(2)*0.5:0.01:PlaneCenter(2)+BodySize(2)*0.5)); PlaneCenter(2)-BodySize(2)*0.5:0.01:PlaneCenter(2)+BodySize(2)*0.5];

%hangar
topwall = [0:0.01:7 ; 3*ones(1,length(0:0.01:7))];
leftwall = [zeros(1,length(0.001:0.01:3));0.001:0.01:3];
rightwall = [7*ones(1,length(0:0.01:3));0:0.01:3];
bottomwall = [0:0.01:7 ; zeros(1,length(0:0.01:7))];

a=[topwall(1,:),leftwall(1,:),rightwall(1,:),bottomwall(1,:) bodyl(1,:) bodyr(1,:) bodytop(1,:) bodybot(1,:) wingtop(1,:) wingbot(1,:) wingl(1,:) wingr(1,:)]';
b=[topwall(2,:),leftwall(2,:),rightwall(2,:),bottomwall(2,:) bodyl(2,:) bodyr(2,:) bodytop(2,:) bodybot(2,:) wingtop(2,:) wingbot(2,:) wingl(2,:) wingr(2,:)]';
setOccupancy(plen,[a b], ones(length(a),1))
figure
show(plen)

