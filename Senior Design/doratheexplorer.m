function LePath=doratheexplorer(tag1,tag2,RoutingMatrix,IDVector,compass,RMatrix,HMatrix)
%FUNCTION CODEs
LeTags=vectormaker(tag1,tag2,RoutingMatrix,IDVector);
for i=1:length(LeTags)-1
[resultvector(i) RMatrix HMatrix]=rotationplotter(LeTags(i),LeTags(i+1),IDVector,compass,RMatrix,HMatrix);
end
for a=1:length(resultvector)
    LePath(a)=strcat(num2str(LeTags(a)),resultvector(a));
end
LePath(length(LeTags))=strcat(num2str(LeTags(length(LeTags))),"S");
end