load('userparam.mat', 'loadFilePath')
load('userparam.mat', 'saveFilePath');
disp(['using temporary load path', loadFilePath])
disp(['using temporary save path', saveFilePath]);

[srcFilename, srcPathname] = uigetfile('*.avi', 'Open Reflective Video For Evaluating', loadFilePath);

[rezFilename, rezPathname] = uiputfile('*.avi', 'Save', saveFilePath);

if ~isequal(srcFilename, 0) && ~isequal(rezFilename, 0)
    srcPathfilename = strcat(srcPathname, srcFilename);
    rezPathFilename = strcat(rezPathname, rezFilename);

    % Initialize video reader
    v = VideoReader(srcPathfilename);
    
    % Initialize video writer
    vWR = VideoWriter(rezPathFilename);
    open(vWR);
    
    for iFrame = 1:1000
        if mod(iFrame, 10) == 0
            disp(["frame number", iFrame]);
        end
        nextFrame = readFrame(v);    
        
        nextFrame = insertShape(nextFrame,'line',[trace_1.x(iFrame), trace_1.y(iFrame) trace_2.x(iFrame), trace_2.y(iFrame)],'LineWidth',4, 'Color', 'green','Opacity',0.7);
        nextFrame = insertShape(nextFrame,'line',[trace_2.x(iFrame), trace_2.y(iFrame) trace_3.x(iFrame), trace_3.y(iFrame)],'LineWidth',4, 'Color', 'green','Opacity',0.7);
        
        nextFrame = insertShape(nextFrame,'circle',[trace_1.x(iFrame), trace_1.y(iFrame) 25],'LineWidth',4);
        nextFrame = insertShape(nextFrame,'circle',[trace_2.x(iFrame), trace_2.y(iFrame) 25],'LineWidth',4);
        nextFrame = insertShape(nextFrame,'circle',[trace_3.x(iFrame), trace_3.y(iFrame) 25],'LineWidth',4);
        
        writeVideo(vWR, nextFrame);
    end
    
    close(vWR)
end