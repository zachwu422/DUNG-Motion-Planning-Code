%void setup code (basically shit that only has to be run once)
clearvars
noplanecompass=string(readcell("DemoNoPlane.csv")); %noplane compass import
noplane=matrixconverter(noplanecompass); %noplane FW matrix conversion
planecompass=string(readcell("DemoPlane.csv")); %plane compass import
plane=matrixconverter(planecompass); %plane FW matrix conversion
PlaneID=load('IndicePlane.csv'); %RTFM
NoPlaneID=load('IndiceNoPlane.csv'); %what it says
[S2,NoPlaneP]=floydwarsall(noplane);
[S1,PlaneP]=floydwarsall(plane);
rrm=["0" "FF" "0" ;
     "RL" "0" "RR"; 
     "0" "BB" "0";];
rhm=["0" "N" "0";
    "W" "0" "E";
    "0" "S" "0";];
%hangar definitions
hangarbase.h1=[11 15 16];
hangarbase.p1=[51 55 56];
hangarbase.m1=[71 75 76];
hangarbase.home=[1 3 2];