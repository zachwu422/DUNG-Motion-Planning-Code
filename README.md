This is the code responsible for planning the motions for the D.U.N.G (device uplifting and navigation group) three robot swarm.
It works by inputting a plane ID (the specific plane which must be moved) from a location to another.
The code outputs pathfinding instructions in two distinct phases:
1. Three robots individually being moved.
2. One robot acting as the "master" which receives all instructions, while the other two robots are in "follower" mode mirroring the movements of the front robot.
There are two systems which respectively come before and after this code in the D.U.N.G control workflow: a scheduling system which decides which plane to move at what time, and the low level embedded system saved internally on each robot. Those code files were not written by myself, and as such I do not have access to them.
