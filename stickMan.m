load('userparam.mat', 'loadFilePath')
disp(['using temporary path', loadFilePath])

[filename, pathname] = uigetfile('*.avi', 'Open Reflective Video For Evaluating', loadFilePath);

if filename ~= 0
    pathfilename = strcat(pathname,filename);

    %Read Next frame
    v = VideoReader(pathfilename);
    
    nextFrame = readFrame(v);
    figure
    
    
    imshow(nextFrame);
    hold on
    plot(trace_1.x, trace_1.y)
    plot(trace_2.x, trace_2.y)
    plot(trace_3.x, trace_3.y)
    hold off
end