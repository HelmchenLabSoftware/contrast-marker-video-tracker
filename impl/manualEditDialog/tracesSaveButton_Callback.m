% --- Executes on button press in tracesSaveButton.
function tracesSaveButton_Callback(hObject, eventdata, handles)
    % =====================================
    % Open dialog for file selection
    % =====================================
    % Use most recently used path from parameters file
    load('userparam.mat', 'saveFilePath');
    disp(['using temporary path', saveFilePath]);
    [filename, pathname] = uiputfile('*.mat', 'Save', saveFilePath);
    assert(filename ~= 0, 'Bad filename');
    resultFilePathName = strcat(pathname,filename);

    % Save most recent path to parameters file
    saveFilePath = pathname;
    save('userparam.mat', 'saveFilePath', '-append');

    
    % =====================================
    % Auto-interpolate x-y and write to file
    % =====================================
    if isempty(handles.traceIndices)
        fprintf("No traces selected - aborting file writing!")
    else
        for iTrace = 1:length(handles.traceIndices)
            thisTrace = handles.old_list{handles.traceIndices(iTrIdx)};
            thisTraceInterp = struct();
            thisTraceInterp.x = [];
            thisTraceInterp.y = [];
            
            for iFrame = 1:length(thisTrace)
                if iFrame == 1
                    thisTraceInterp.x = [thisTraceInterp.x thisTrace(iFrame).x];
                    thisTraceInterp.y = [thisTraceInterp.y thisTrace(iFrame).y];
                else
                    if thisTrace(iFrame).f - thisTrace(iFrame-1).f == 1
                        thisTraceInterp.x = [thisTraceInterp.x thisTrace(iFrame).x];
                        thisTraceInterp.y = [thisTraceInterp.y thisTrace(iFrame).y];
                    else
                        % If this is not the first frame, and the gap
                        % between this datapoint and previous is more than
                        % one frame, then need to interpolate
                        thisFrames =  thisTrace(iFrame-1).f : thisTrace(iFrame).f;
                        thisX = linspace(thisTrace(iFrame-1).x, thisTrace(iFrame-1).x, length(thisFrames));
                        thisY = linspace(thisTrace(iFrame-1).y, thisTrace(iFrame-1).y, length(thisFrames));
                        
                        % Ignore the first interpolation point, as it has
                        % already been added during previous step
                        thisTraceInterp.x = [thisTraceInterp.x thisX(2:end)];
                        thisTraceInterp.y = [thisTraceInterp.y thisY(2:end)];
                    end
                end
            end
            
            tmp.(strcat('trace_', string(iTrace))) = thisTraceInterp;
            save(resultFilePathName, 'tmp', '-append', '-struct');
        end 
    end
end