%YOUSIF PSEUDOCODE
command="h1p1";
if command=="home"
    Start=hangarbase.home;
    End=hangarbase.home;
else
splitinput=split(command,"",2);
splitinput(6)=[];
splitinput(1)=[];
result=[strcat(splitinput(1),splitinput(2)) strcat(splitinput(3),splitinput(4))];
Start=hangarbase.(result(1));
End=hangarbase.(result(2));
end
%MISO PSEUDOCODE: Relay bot current position
ToPlane1=doratheexplorer(2,Start(1),NoPlaneP,NoPlaneID,noplanecompass,rrm,rhm);
ToPlane2=doratheexplorer(1,Start(2),NoPlaneP,NoPlaneID,noplanecompass,rrm,rhm);
ToPlane3=doratheexplorer(3,Start(3),NoPlaneP,NoPlaneID,noplanecompass,rrm,rhm);
%SEND INSTRUCTIONS AND CONFIRM
MovePlane1=doratheexplorer(Start(1),End(1),PlaneP,PlaneID,planecompass,rrm,rhm);
%DISMOUNT PLANE and RETURN HOME