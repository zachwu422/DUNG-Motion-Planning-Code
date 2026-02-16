plen=binaryOccupancyMap(7,3,20);

%THE PLENMASTER (we got square planes before GTA 6)

WingSize=[2 0.25]; %Wing Dimensions in units of whatever
BodySize=[0.5 1.4]; %Fuselage Dimensions in units of whatever
PlaneCenter=[3 1.4]; %Location of Plane in Hangar in units of whatever

WingCenterFactor=-0.8; 
%Multiplier Determining plane direction and wing location proportional to
%fuselage. Maximum recommended value is +-0.8

%THE ROUTEMASTER that is better than the actual london bus

resolution=1;
startLocation = [1 2].*resolution;
endLocation = [6 1].*resolution;

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


%Spawn Robot
robot = differentialDriveKinematics("TrackWidth", 0.3, "VehicleInputs", "VehicleSpeedHeadingRate");


map = plen;
figure
show(map)
mapInflated = copy(map);

%Controls how much McDonalds is fed to obstacles

inflate(mapInflated, robot.TrackWidth/2);
prm = robotics.PRM(mapInflated);
prm.NumNodes = 100;
prm.ConnectionDistance = 10;


%Escape route calculator

path = findpath(prm, startLocation, endLocation);
show(prm);
controller = controllerPurePursuit;
controller.Waypoints = path;
robotInitialLocation = path(1,:);
robotGoal = path(end,:);
initialOrientation = 0;
robotCurrentPose = [robotInitialLocation initialOrientation]';
distanceToGoal = norm(robotInitialLocation - robotGoal);
goalRadius = 0.1;
sampleTime = 0.1;
vizRate = rateControl(1/sampleTime);

% Initialize the figure
figure
frameSize = robot.TrackWidth/0.8;

while( distanceToGoal > goalRadius )
    
    % Compute the controller outputs, i.e., the inputs to the robot
    [v, omega] = controller(robotCurrentPose);
    
    % Get the robot's velocity using controller inputs
    vel = derivative(robot, robotCurrentPose, [v omega]);
    
    % Update the current pose
    robotCurrentPose = robotCurrentPose + vel*sampleTime; 
    
    % Re-compute the distance to the goal
    distanceToGoal = norm(robotCurrentPose(1:2) - robotGoal(:));
    
    % Update the plot
    hold off
    show(map);
    hold all

    % Plot path each instance so that it stays persistent while robot mesh
    % moves
    plot(path(:,1), path(:,2),"k--d")
    
    % Plot the path of the robot as a set of transforms
    plotTrVec = [robotCurrentPose(1:2); 0];
    plotRot = axang2quat([0 0 1 robotCurrentPose(3)]);
    plotTransforms(plotTrVec', plotRot, 'MeshFilePath', 'groundvehicle.stl', 'Parent', gca, "View","2D", "FrameSize", frameSize);
    light;
    xlim([0 7])
    ylim([0 3])
    
    waitfor(vizRate);
end