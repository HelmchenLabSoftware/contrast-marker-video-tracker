% --- Executes on slider movement.
% Separates image into individual regions. Recombines nearby regions.
% For details see https://blogs.mathworks.com/steve/2010/09/07/almost-connected-component-labeling/
function spaceMergeMaxDistSlider_Callback(hObject, eventdata, handles)
    recombRadius = get(handles.spaceMergeMaxDistSlider, 'Value');