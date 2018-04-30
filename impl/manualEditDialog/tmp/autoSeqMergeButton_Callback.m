% --- Executes on button press in seqMergeButton.
%{

Target: Attempt to merge interrupted traces. In case if
  1) Target disappeared, and there is a small gap between traces
  2) Target split in two: then if
     _//- one trajectory terminates after other starts, there is an overlap
     _/=\ the main trajectory does not terminate, but split hangs in the air

Algorithm 1: Search for continuations
  * Loop over trajectories sorted by their total length
  * If the trajectory does not start at 1, search for predecessor, otherwise successor
  * Search for other trajectories that have small gap or small overlap with this one
    - Give high preference to other long trajectories.
    - Evaluate gap based on L2 between edge points. Probably also need trajectory correlation
    - Evaluate overlap based on L2 during overlap, and L2 of merged overlap vs regions before and after
  * If match finding fails, or trajectory as long as video, move it to complete and continue
  
  
Algorithm 2: Search for merges (after algorithm 2 has finished)

%}

function seqMergeButton_Callback(hObject, eventdata, handles)

    % 1. Sort incoming lists by contiguous frame count
    nFrame = [];
    for iRegOld = 1:length(handles.old_list)
        nFrame = [nFrame length(handles.old_list{iRegOld}.f)];
    end
    
    [~, sortIdx] = sort(nFrame, 'descend');
    handles.old_list = handles.old_list(sortIdx);
    
    % 2. Calculate distances for the back of the frst sequence, sort them
    % ascendingly
    fprintf("longest entry starts at frame %i and ends at %i \n", handles.old_list{1}.f(1), handles.old_list{1}.f(end))
    
    endfr = handles.old_list{1}.f(1);
    v1 = double([handles.old_list{1}.x(1) handles.old_list{1}.y(1) handles.old_list{1}.m(1)]);
    
    frameIdx = [];
    distFrameFull = [];
    distFrameAbs = [];
    distL2 = [];
    for iRegOld = 2:length(handles.old_list)
        begfr = handles.old_list{iRegOld}.f(end);
        frameIdx = [frameIdx iRegOld];
        distFrameFull = [distFrameFull endfr - begfr];
        distFrameAbs = [distFrameAbs abs(endfr - begfr)];
        
        v2 = double([handles.old_list{iRegOld}.x(end) handles.old_list{iRegOld}.y(end) handles.old_list{iRegOld}.m(end)]);
        distL2 = [distL2 DistL2Reg(v1, v2)];
    end
    
    [~, sortIdx] = sort(distFrameAbs);
    frameIdx = frameIdx(sortIdx);
    distFrameFull = distFrameFull(sortIdx);
    distL2 = distL2(sortIdx);
    
    
    disp(frameIdx(1:10))
    disp(distFrameFull(1:10))
    disp(distL2(1:10))
    
    %{
    Naive alg. No1:
    1) Loop over all trajectories, longest to shortest
    2) Filter all tails that are within +/-10 frames of each other
    3) Of those, ignore all where L2 norm too big
    4) If both trajectories short (<10), ignore if intersect
    5) Print number of options for each trajectory. If one option much
    better than others, intersect.
    %}
    
end