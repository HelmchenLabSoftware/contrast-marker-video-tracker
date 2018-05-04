% --- Executes on button press in timeMergeButton.
%{
    Algorithm for time-merge:
        1) Have old_list and prev_list - both cell-array[cellNo][frame]
        2) Put regions from frame 1 into prev_list
        3) For each new frame
            3.1) Calculate L2 for each pair of most recent prev regions and
            the current frame regions. Compute rectangular matrix and
            complete it to square matrix adding fake 0-rows or 0-cols.
            3.2) Minimize total distance by Munkres algorithm - get
            pairings of regions. 
            3.4) For each new region in the matrix
                * If new region fake, add linked current region to new
                * If current region fake, move linked new region to old
                * If both real, append current to old
%}
function tracesTimeMergeButton_Callback(hObject, eventdata, handles)

    L2_THRESHOLD = 10;

    handles.old_list = {};  % Stores all currently-finished traces
    prev_list = {};         % Stores all currently-unfinished traces
    currentFrameReg = 0;    % Counter of current frame-region input idx
    
    % FILL IN REGIONS FROM FIRST FRAME
    for j = 1:handles.regioncount(1)
        currentFrameReg = currentFrameReg + 1;
        prev_list{j}.f = [1];
        prev_list{j}.x = [handles.ProcessedXList(currentFrameReg)];
        prev_list{j}.y = [handles.ProcessedYList(currentFrameReg)];
        prev_list{j}.m = [handles.ProcessedMList(currentFrameReg)];
    end
    
    for iFrame = 2:length(handles.regioncount)
        thisRegCount = handles.regioncount(iFrame);     % Number of current regions
        prevRegCount = handles.regioncount(iFrame-1);   % Number of recent previous regions
        
        fprintf("Frame %d, this_reg=%d, prev_reg=%d, test=%d \n", iFrame, thisRegCount, prevRegCount, length(prev_list));
        
        % PREALLOCATE MEMORY FOR REGIONS OF THIS FRAME
        % ----------FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME--
        clear this_list;
        %this_list = zeros(1, thisRegCount);
        this_dist_M = zeros(prevRegCount, thisRegCount);
        
        % READ REGIONS OF THIS FRAME, COMPUTE PAIRWISE DISTANCE TO PREV
        for iRegThis = 1:thisRegCount
            currentFrameReg = currentFrameReg + 1;
            this_list(iRegThis).f = iFrame;
            this_list(iRegThis).x = handles.ProcessedXList(currentFrameReg);
            this_list(iRegThis).y = handles.ProcessedYList(currentFrameReg);
            this_list(iRegThis).m = handles.ProcessedMList(currentFrameReg);
            
            for iRegPrev = 1:prevRegCount
                prevReg = prev_list{iRegPrev};
                v1 = double([this_list(iRegThis).x this_list(iRegThis).y this_list(iRegThis).m]);
                v2 = double([prevReg.x(end) prevReg.y(end) prevReg.m(end)]);
                this_dist_M(iRegPrev, iRegThis) = DistL2Reg(v1, v2);
            end
        end
        
                
        % SOLVE THE ASSIGNMENT OPTIMIZATION PROBLEM TO DETERMINE WHICH
        % REGION MATCHES BEST TO WHICH
        [assig, notCol] = assignmentAlgWrapperThresh(this_dist_M, L2_THRESHOLD, L2_THRESHOLD);
        
        
        
%         if iFrame == 1655
%             disp(this_dist_M_aug)
%             disp(assig)
%             
%             for z1 =1:prevRegCount
%                 fprintf("prev = %d %d %d \n", prev_list{z1}.x(end), prev_list{z1}.y(end), prev_list{z1}.m(end));
%             end
% 
%             for z2 =1:thisRegCount
%                 fprintf("this = %d %d %d \n", this_list(z2).x, this_list(z2).y, this_list(z2).m);
%             end
%             
% %             LLLL1 = double([this_list(1).x this_list(1).y this_list(1).m])
% %             LLLL2 = double([prev_list{6}.x(end) prev_list{6}.y(end), prev_list{6}.m(end)])
% %             disp(DistL2Reg(LLLL1, LLLL2));
%         end
        
        
        for iRegPrev = 1:prevRegCount
            iRegThis = assig(iRegPrev);
                    
            % ADD ALL UNPAIRED PREV REGIONS TO OLD
            if iRegThis == 0
                handles.old_list{end + 1} = prev_list{iRegPrev};
                
            % MERGE ALL PAIRED THIS REGIONS INTO PREV
            else
                prev_list{iRegPrev}.f = [prev_list{iRegPrev}.f this_list(iRegThis).f];
                prev_list{iRegPrev}.x = [prev_list{iRegPrev}.x this_list(iRegThis).x];
                prev_list{iRegPrev}.y = [prev_list{iRegPrev}.y this_list(iRegThis).y];
                prev_list{iRegPrev}.m = [prev_list{iRegPrev}.m this_list(iRegThis).m];
            end
        end
        
        % UPDATE THE PREV LIST BY REMOVING REGIONS THAT WERE MOVED TO OLD
        prev_list(assig == 0) = [];

        % ADD ALL UNPAIRED THIS REGIONS TO PREV
        for iThisUnpaired = 1:length(notCol)
            prev_list{end + 1} = [this_list(notCol(iThisUnpaired))];
        end

    end
    
    % MERGE UNMERGED PREV INTO OLD
    % -----------TODO: Replace with vertcat if it works on cellArrays----
    for iRegPrev = 1:length(prev_list)
        handles.old_list{end + 1} = prev_list{iRegPrev};
    end
    
    % Fill resulting traces into the table. Store map from trace to table index
    handles.idxTrace2Table = tracesFillIntoTable(hObject, eventdata, handles);
    
    % Store selected table indices, and that the table was created
    handles.haveTimeMerge = 1;
    handles.traceIndices = [];
    
    % Update plot
    handles.plotHandles = plotChooseTracesROI(handles);
    
    % Save data
    guidata( hObject, handles);
end