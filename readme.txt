**A Matlab contrast based joint tracker. While it worked ok it was clearly outperformed by DeepLabCut and hence discontinued**

Status	CanAuto		Description
---------------------------------------------------------
           GUI
---------------------------------------------------------
Done	0		MATLAB GUI loads video using interface
Done	0		Implement slider to move between frames during parameter selection
Done	0		Write video file
Done	0			Open dialog to save movie. Use filename.
---------------------------------------------------------
           Preprocess
---------------------------------------------------------
Done	BetaTest	Background is subtracted using smooth average. User selects smoothing parameter using slider
Done	0		User selects contrast gap using 2 sliders, to discard as much unrelated regions as possible
---------------------------------------------------------
           Region space-identification
---------------------------------------------------------
Done	+		Frame is binarized and identified via bwconncomp
Done	0		User can input expected inter-object gap and noise size
Done	+		Zealous ROI separation algorithm using region inflation and intersection
Done			Enable overlay of ROI over original frames
TODO			Improve ROI identification
TODO				Ability to use different distance-threshold for different x-y areas
TODO				Apply max size within x-y range. If too big, equi-split via long axis or use watershed or sth.
---------------------------------------------------------
           Region space-merge
---------------------------------------------------------
?????? Done	BetaTest	Implement space-merge algorithm.
?????? Done	BetaTest	Implement post space-merge filter algorithm. Make 2 sliders for min and max area
---------------------------------------------------------
           Region time-merge
---------------------------------------------------------
Done	0		Implement next stage of GUI for collective region analysis
Done	+		Determine centroids(x,y) and areas of all regions and plot them as function of time
Done	BetaTest	Implement time-merge algorithm using nearest centroid.
TODO				Advanced options: Gui enable edit of L2 absolute and relative thresholds, as well as ratio xy vs size.
TODO	BetaTest	Implement angular predictor for 2nd re-run. The 5 ROI can make a sequence of angles with certain constraints. Redo time-merge by penalising constraints

---------------------------------------------------------
           Region seq-merge
---------------------------------------------------------
TODO	BetaTest	Implement time-seq-merge
TODO	BetaTest	Implement manual user merge. Allow click on two trajectories and force them to be merged
TODO	BetaTest	Implement manual user unmerge. Allow click on an edge, and break trajectories apart on that edge

---------------------------------------------------------
           Filtering
---------------------------------------------------------

TODO	BetaTest	Implement manual time-seq deletion.
---------------------------------------------------------
           Save results
---------------------------------------------------------
TODO			Implement video writing with connecting lines
TODO			Implement save seq to file. Index seq by average y-coordinate.



Bugs:
	Region splits in two for a few frames, then merge back together -> Code does not notice it is the same region.
		- Implement intersecting trajectory merge: if
 			* one trajectory starts a few frames before 2nd trajectory ends, and
			* pure distance during intersection is small, and
			* size of first just before intersect is approx same as sizes of two combined during intersect, then merge

	Tons of Junk
		- Implement individual filters for x,y,m
		- Implement combined filters

	Paw can get close to shoulder. If shoulder disappears, it is possible that new paw is closer to the original shoulder than to original paw
		[x] Already framerate 100px - can't improve further

	Tail hides regions
		- Pia: can tail be restricted from getting in front of the camera











