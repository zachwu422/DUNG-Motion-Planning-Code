%INPUT LIST:
%(Start,End,InitialStrafeMatrix,P,IDVector,PlaneCompass)
function LePath=bobthebuilder(Start,End,InitialStrafeMatrix,P,IDVector,PlaneCompass)

%Heading Digit
dgt=num2str(Start)-'0';

R1=vectormaker(Start,End,P,IDVector);
%Plot the directions that the robot must go FROM THE TAG THAT THEY ARE ON
i=1;
while i<=length(R1)-1
    [headingresult(i),globalheading]=headingplotter(R1(i),R1(i+1),IDVector,PlaneCompass,CurrentStrafeMatrix,globalheading);
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
end