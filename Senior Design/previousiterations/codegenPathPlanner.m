function path = codegenPathPlanner(mapData,startPose,goalPose)
map = binaryOccupancyMap(mapData);
stateSpace=stateSpaceSE2;
stateSpace.StateBounds = [map.XWorldLimits;map.YWorldLimits;[-pi pi]];
validator=validatorOccupancyMap(stateSpace,Map=map);
validator.ValidationDistance = 0.1; %original cvalue 0.1
planner = plannerHybridAStar(validator);
pathObj = plan(planner,startPose,goalPose);
path=pathObj.States;
end
