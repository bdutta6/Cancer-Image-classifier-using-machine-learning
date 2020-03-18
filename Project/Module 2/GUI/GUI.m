function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 04-Apr-2016 18:17:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Clear all axes
arrayfun(@(x) set(x,'visible','off'),findall(0,'type','axes'))

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get the image
[filename, pathname] = uigetfile({'*.png'},'Select the image to be segmented');
fullpathname = [pathname filename];
imageOriginal = imread(fullpathname);

% Display the Dataset
noDataset = pathname(end-11);
switch noDataset;
    case '1'
        noDataset = 1;
        classes = sprintf('- Necrosis\n- Stroma\n- Tumor');  
    case '2'
        noDataset = 2;
        classes = sprintf('- Grade1\n- Grade2\n- Grade3\n- Grade4');
    case '3'
        noDataset = 3;
        classes = sprintf('- Grade1\n- Grade2\n- Grade3\n- Grade4');
end
text4 = sprintf('Current dataset : %d\nClasses :\n%s',noDataset, classes);
set(handles.text4, 'String', text4);

% Show the image
set(handles.text1, 'String', filename);
imshow(imageOriginal,'Parent', handles.axes1);

% Get the GroundTruth
pathGroundTruth = pathname(1:end-10);
pathGroundTruth = [pathGroundTruth 'Groundtruth/'];
fileGroundTruth = filename(1:end-4);
fileGroundTruth = [fileGroundTruth '_GT.png'];
fullpathname = [pathGroundTruth fileGroundTruth];
try
    imageGroundTruth = imread(fullpathname);
catch
    disp('No ground truth for this reference');
    imageGroundTruth = uint8(zeros(512,512));
end
% Show the GroundTruth
axes(handles.axes5),imshow(imageGroundTruth);

% Get the normalized image
pathname = pathname(1:end-10);
pathname = [pathname 'Normalized/'];
fullpathname = [pathname filename];
try
imageNormalized = imread(fullpathname);
catch
    disp('No normalized image for this reference');
    imageNormalized = uint8(zeros(512,512));
end

% Show the normalized image
imshow(imageNormalized,'Parent', handles.axes2);

% Save the handles structure.
handles.pathname = pathname;
handles.filename = filename;
handles.imageOriginal = imageOriginal;
handles.imageGroundTruth = imageGroundTruth;
handles.imageNormalized = imageNormalized;
handles.noDataset = noDataset;
guidata(hObject,handles)

% Call the segmentation
popupmenu1_Callback(handles.popupmenu1, eventdata, handles);

% cla(handles.axes2);set(handles.axes2,'visible','off');
% cla(handles.axes4);set(handles.axes4,'visible','off');
% cla(handles.axes5);set(handles.axes5,'visible','off');
% cla(handles.axes6);set(handles.axes6,'visible','off');


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

% Determine the selected command.
str = get(hObject, 'String');
val = get(hObject,'Value');

% Set current data to the selected data set.
switch str{val};
    case 'Segmentation'
        %set(handles.slider1,'visible','off');
        %set(handles.slider1Text, 'String', '');
        cla(handles.axes4);set(handles.axes4,'visible','off');
        cla(handles.axes5);set(handles.axes5,'visible','off');
        cla(handles.axes6);set(handles.axes6,'visible','off');
    case 'Supervised'
        noSeg = 1;
        %% Load preprocessed image from Supervised/ folder
        pathname = handles.pathname(1:end-11);
        pathname = [pathname 'Supervised/90supervised_rnd/'];
        filename = handles.filename(1:end-4);
        filename = [filename '.png'];
        fullpathname = [pathname filename];
        imageSegmented = imread(fullpathname);
        
        %% Generate segmented image from scratch
%         % load classifier
%         pathname = handles.pathname(1:end-10);
%         pathname = [pathname 'Classifiers/'];
%         
%         [filename pathname] = uigetfile('*.mat', 'Select the pre-trained LDA classifier', pathname);
%         % tmp
%         %ratio_val = str2num(filename(end-5:end-4));
%         %set(handles.slider1,'visible','on');
%         %set(handles.slider1, 'Value', ratio_val / 100);
%         %text = sprintf('Percentage of images for LDA training: %d', ratio_val);
%         %set(handles.slider1Text, 'String', text);
%         
%         fullpathname = [pathname filename];
%         class_weights = load(fullpathname);
%         
%         init_segmented_image = ldaclassifier(handles.imageNormalized, class_weights);
%         init_segmented_image(init_segmented_image==1)=0;
%         init_segmented_image(init_segmented_image==2)=128;
%         init_segmented_image(init_segmented_image==3)=255;
%         
%         imageSegmented = levelSetSmooth_single(im2double(handles.imageNormalized), init_segmented_image, 0.2, 100);
%         imageSegmented = uint8(imageSegmented);
        
    case 'Unsupervised'
        noSeg = 2;
        %set(handles.slider1,'visible','on');
        %alpha = get(handles.slider1,'Value');
        %text = sprintf('Alpha : %.2f',alpha);
        %set(handles.slider1Text, 'String', text);
        
        %% Load preprocessed image from Unsupervised/ folder
         pathname = handles.pathname(1:end-11);
         pathname = [pathname 'Unsupervised/'];
         filename = handles.filename;
         fullpathname = [pathname filename];
         imageSegmented = imread(fullpathname);
        
        %% Generate segmented image from scratch
%         imageSegmented = unsupervisedSegmentation_single(im2double(handles.imageNormalized), alpha, 3);
%         imageSegmented = uint8(imageSegmented);
end

% If there is a segmentation type selected
if val ~= 1
    imagePseudoColor = zeros(512,512,3);
    for i = 1:512
        for j = 1:512
            if imageSegmented(i,j) == 0
                imagePseudoColor(i,j,:) = [0 0 255];
            elseif imageSegmented(i,j) == 128
                imagePseudoColor(i,j,:) = [255 0 255];
            else
                imagePseudoColor(i,j,:) = [255 255 255];
            end
        end
    end
    imageDifference = abs(im2double(handles.imageGroundTruth) - im2double(imageSegmented));
    
    % Show the segmented image
    axes(handles.axes3),imshow(imageSegmented);
    % Show the pseudocolor image
    axes(handles.axes4),imshow(imagePseudoColor);
    % Show the difference evaluation
    axes(handles.axes6),imshow(imageDifference);
    
    % Save the handles structure.
    handles.imageSegmented = imageSegmented;
    handles.imagePseudoColor = imagePseudoColor;
    handles.imageDifference = imageDifference;
    handles.noSeg = noSeg;
    guidata(hObject,handles);
end

% Call the metrics
popupmenu2_Callback(handles.popupmenu2, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
% Determine the selected metric.
str = get(hObject, 'String');
val = get(hObject,'Value');

% Set current metric to the selected metric set.
switch str{val};
    case 'Metrics'
        text3 = 'Metric ...';
        set(handles.text3, 'String', text3);
    case 'Rand Index'
        imageSegmented = handles.imageSegmented;
        imageGroundTruth = handles.imageGroundTruth;
        randIndex = metricRandIndex(imageSegmented,imageGroundTruth);
        text3 = sprintf('Rand index : %.2f',randIndex);
        set(handles.text3, 'String', text3);
    case 'Intra Index'
        imageSegmented = handles.imageSegmented;
        intraIndex = metricIntraIndex(handles.imageNormalized,imageSegmented);
        text3 = sprintf('Intra Index : %.2f',intraIndex);
        set(handles.text3, 'String', text3);
    case 'Inter Index'
        imageSegmented = handles.imageSegmented;
        interIndex = metricInterIndex(handles.imageNormalized,imageSegmented);
        text3 = sprintf('Inter Index : %.2f',interIndex);
        set(handles.text3, 'String', text3);
end


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3

%% Extract features
%TODO Retrieve features
%all_features = extractFeatures(handles.noDataset, handles.noSeg);

% Load features
pathname = handles.pathname(1:end-11);
pathname = [pathname 'Features/'];  
filename = 'all_features.mat';
% Returns 'all_features' variable
load([pathname, filename]);
all_features(isnan(all_features))=0;
handles.all_features = all_features;

% Load labels for classes
pathname = handles.pathname(1:end-11);
pathname = [pathname 'Labels/'];  
filename = 'labels.mat';
% Returns 'labels' variable
load([pathname, filename]);
handles.labels = labels;

% Load random index for metrics
pathname = handles.pathname(1:end-11);
pathname = [pathname 'Index/'];  
filename = 'idx.mat';
% Returns 'idx' variable
load([pathname, filename]);
handles.idx = idx; 

% Get parameters
weight = get(handles.slider1,'Value');
%ql = get(handles.slider2,'Value');

% Determine the feature selection algorithm.
str = get(hObject, 'String');
val = get(hObject,'Value');

% Run current feature selection
switch str{val};
    case 'Feature selection'
        cla(handles.axes7);set(handles.axes7,'visible','off');
    case 'Statistical Dependency Ranking'
        %selected_features = selectFeatures_SD(all_features,labels,ql,weight);
        selected_features = selectFeatures_SD(all_features,labels,3,weight);
    case 'Mutual Information'
        %selected_features = selectFeatures_MI(all_features,labels,ql);
        [selected_features, idx_features] = selectFeatures_MI(all_features,labels,12,handles.noDataset);
        handles.idx_features = idx_features;
    case 'Combination'
        selected_features1 = selectFeatures_SD(all_features,labels,3,weight);
        [selected_features2, idx_features] = selectFeatures_MI(all_features,labels,12,handles.noDataset);
        selected_features = horzcat(selected_features1, selected_features2);
end

% If there is a feature selection type selected
if val ~= 1
    % Save the handles structure.
    handles.selected_features = selected_features;
    guidata(hObject,handles);
    % Call the feature reduction
    popupmenu4_Callback(handles.popupmenu4, eventdata, handles);
end

% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4

%% Reduce features
% Get number of desired dimensions
strDims = get(handles.popupmenu5, 'String');
valDims = get(handles.popupmenu5,'Value');
switch strDims{valDims};
    case 'noDims = 3'
        noDims = 3;
    case 'noDims = 2'
        noDims = 2;
    case 'noDims = 1'
        noDims = 1;
end

% Determine the feature reduction algorithm.
str = get(hObject, 'String');
val = get(hObject,'Value');

% Run current feature selection
switch str{val};
    case 'Feature reduction'
        cla(handles.axes7);set(handles.axes7,'visible','off');
    case 'PCA'
        reduced_features = reduceFeatures_PCA(handles.selected_features, noDims);
    case 't-SNE'
        reduced_features = reduceFeatures_tSNE(handles.selected_features, noDims);
end

% If there is a feature selection type selected
if val ~= 1
    % Display scatterplot
    displayFeatures(handles.axes7, handles.noDataset, reduced_features, handles.labels, noDims);
    % Display performance metrics
    displayMetrics(handles.text5, handles.idx_features, handles.all_features, handles.labels, handles.idx, handles.noDataset);
    
    % Save the handles structure.
    handles.reduced_features = reduced_features;
    guidata(hObject,handles);
end


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5

% Call the feature reduction
popupmenu4_Callback(handles.popupmenu4, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% Get slider value
weight = get(hObject,'Value');
text = sprintf('Weight : %.2f',weight);
set(handles.text6, 'String', text);

% Call selection function
popupmenu3_Callback(handles.popupmenu3, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% Get slider value
ql = get(hObject,'Value');
text = sprintf('Quantization Level : %.2f',ql);
set(handles.text7, 'String', text);

% Call selection function
popupmenu3_Callback(handles.popupmenu3, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
