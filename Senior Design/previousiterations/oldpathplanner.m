map = skinnymap;
mapData = occupancyMatrix(map);

%Map parameters

startcoord=[0.5 0.5 0];
goalcoord=[6 2.9 (pi)/2];
resolution=20;
startPose = [startcoord(1)*resolution startcoord(2)*resolution startcoord(3)];
goalPose = [goalcoord(1)*resolution goalcoord(2)*resolution goalcoord(3)];
path = codegenPathPlanner(mapData,startPose,goalPose);
show(binaryOccupancyMap(mapData))
hold on

% Start state
scatter(startPose(1,1),startPose(1,2),"g","filled")
% Goal state
scatter(goalPose(1,1),goalPose(1,2),"r","filled")
% Path
plot(path(:,1),path(:,2),"r-",LineWidth=2)
legend("Start Pose","Goal Pose","MATLAB Generated Path")
legend(Location="northwest")