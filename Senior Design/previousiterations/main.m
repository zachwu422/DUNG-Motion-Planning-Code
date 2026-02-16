
%For making the code work (this will be deleted later)
Start=11;
End=71;


%Heading Digit
dgt=num2str(Start)-'0';

%Set Global System Heading
if dgt(1)==5 || dgt(1)==6 ||dgt(1)==7
    globalheading="W";
    CurrentStrafeMatrix=flip(InitialStrafeMatrix');
else
    globalheading="N";
    CurrentStrafeMatrix=InitialStrafeMatrix;
end

%FROM HERE ON OUT BOB THE BUILDER IS DOING HIS SHIT

%Turn the stuff down here into a single function

%input parameters required:



R1=vectormaker(Start,End,PlaneP,PlaneID);
%Plot the directions that the robot must go FROM THE TAG THAT THEY ARE ON
i=1;
while i<=length(R1)-1
    [headingresult(i),globalheading]=headingplotter(R1(i),R1(i+1),PlaneID,planecompass,CurrentStrafeMatrix,globalheading);
    if globalheading=="W"
        CurrentStrafeMatrix=flip(InitialStrafeMatrix');
        i=i+1;
    elseif globalheading=="N"
        CurrentStrafeMatrix=InitialStrafeMatrix;
        i=i+1;
    end
end
%concatenator that molds both vectors together
for a=1:length(headingresult)
    LePath(a)=strcat(num2str(R1(a)),headingresult(a));
end
LePath(length(R1))=strcat(num2str(R1(length(R1))),"S");

%Next steps: call the command for a noplane path and a plane path with only
%one line