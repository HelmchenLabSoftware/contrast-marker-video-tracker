% --- Executes on button press in tracesSaveButton.
function tracesSaveButton_Callback(hObject, eventdata, handles)
    % =====================================
    % Open dialog for file selection
    % =====================================
    % Use most recently used path from parameters file
    load('userparam.mat', 'saveFilePath');
    disp(['using temporary path', saveFilePath]);
    [filename, pathname] = uiputfile('*.mat', 'Save', saveFilePath);
    disp(filename)
    disp(isequal(filename, 0))
    assert(~isequal(filename, 0), 'Bad filename');    
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
            thisTrace = handles.old_list{handles.traceIndices(iTrace)};
            thisTraceInterp = struct();
            thisTraceInterp.x = [];
            thisTraceInterp.y = [];
            
            fprintf("trace %i [%i, %i]; before total = %i", iTrace, min(thisTrace.f), max(thisTrace.f), length(thisTrace.f));
            
            for iFrame = 1:length(thisTrace.f)
                if iFrame == 1
                    thisTraceInterp.x = [thisTraceInterp.x thisTrace.x(iFrame)];
                    thisTraceInterp.y = [thisTraceInterp.y thisTrace.y(iFrame)];
                else
                    if thisTrace.f(iFrame) - thisTrace.f(iFrame-1) == 1
                        thisTraceInterp.x = [thisTraceInterp.x thisTrace.x(iFrame)];
                        thisTraceInterp.y = [thisTraceInterp.y thisTrace.y(iFrame)];
                    else
                        % If this is not the first frame, and the gap
                        % between this datapoint and previous is more than
                        % one frame, then need to interpolate
                        thisFrames =  thisTrace.f(iFrame-1) : thisTrace.f(iFrame);
                        thisX = linspace(double(thisTrace.x(iFrame-1)), double(thisTrace.x(iFrame)), length(thisFrames));
                        thisY = linspace(double(thisTrace.y(iFrame-1)), double(thisTrace.y(iFrame)), length(thisFrames));
                        
                        % Ignore the first interpolation point, as it has
                        % already been added during previous step
                        thisTraceInterp.x = [thisTraceInterp.x thisX(2:end)];
                        thisTraceInterp.y = [thisTraceInterp.y thisY(2:end)];
                    end
                end
            end
            
            fprintf(" after total = %i \n", length(thisTraceInterp.x));
            
            tmp.(strcat('trace_', string(iTrace))) = thisTraceInterp;
            
            if iTrace == 1
                save(resultFilePathName, '-struct', 'tmp');
            else
                save(resultFilePathName, '-struct', 'tmp', '-append');
            end
        end 
    end
end