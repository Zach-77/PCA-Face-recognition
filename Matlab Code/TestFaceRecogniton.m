%
%Author Zach Zhang
%this is a course project
%Face recognition using pca
%��������UI

function varargout = TestFaceRecogniton(varargin)
% TESTFACERECOGNITON MATLAB code for TestFaceRecogniton.fig
%      TESTFACERECOGNITON, by itself, creates a new TESTFACERECOGNITON or raises the existing
%      singleton*.
%
%      H = TESTFACERECOGNITON returns the handle to a new TESTFACERECOGNITON or the handle to
%      the existing singleton*.
%
%      TESTFACERECOGNITON('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTFACERECOGNITON.M with the given input arguments.
%
%      TESTFACERECOGNITON('Property','Value',...) creates a new TESTFACERECOGNITON or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TestFaceRecogniton_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TestFaceRecogniton_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TestFaceRecogniton

% Last Modified by GUIDE v2.5 13-May-2020 17:43:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TestFaceRecogniton_OpeningFcn, ...
                   'gui_OutputFcn',  @TestFaceRecogniton_OutputFcn, ...
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


% --- Executes just before TestFaceRecogniton is made visible.
function TestFaceRecogniton_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TestFaceRecogniton (see VARARGIN)

% Choose default command line output for TestFaceRecogniton
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TestFaceRecogniton wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TestFaceRecogniton_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%-----------ѡ���ļ�����ʶ��----------
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global face2recognize;
[filename, path] = uigetfile({'*.jpg'},'choose photo');
str = [path, filename];
image = imread(str);
face2recognize =image;
axes( handles.axes6);
imshow(image);


%------------�ȶ�����������ӽ���������----------
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global base;
global allcoor;
global face2recognize;
global training_num;
disp('Start recognition:......');

        a = face2recognize;
        temp_img_2=imresize(a,[224 184]);
        b = temp_img_2(1:224*184);      
        b=double(b);          
        tcoor= b * base; %�������꣬��1��p�׾���        
        for k=1:training_num                
            mdist1(k)=norm(tcoor-allcoor(k,:));          
        end;          
        %���׽���ʶ����෨     
        [dist,index2]=sort(mdist1);  
        class1=floor(index2(1)/10)+1;        
        class2=floor(index2(2)/10)+1;          
        class3=floor(index2(3)/10)+1;          
        if class1~=class2 && class2~=class3   
            class=class1;           
        elseif class1==class2            
            class=class1;           
        elseif class2==class3       
            class=class2;           
        end;    
        
        %�ҳ����ƶ���ߵ�����ͼ�ͽ��ͼ
        img1 = fileNum(index2(1));
        img2 = fileNum(index2(2));
        img3 = fileNum(index2(3));
  
        similar_1 = imread(strcat('F:\ͼ�δ���\EESM5547\pgm\jpgTraining\',img1,'.jpg'));
        similar_2 = imread(strcat('F:\ͼ�δ���\EESM5547\pgm\jpgTraining\',img2,'.jpg'));
        similar_3 = imread(strcat('F:\ͼ�δ���\EESM5547\pgm\jpgTraining\',img3,'.jpg'));
        
        if class==class1
            result=img1;
        elseif class==class2;
            result=img2;
        else
            result=img3;
        end
        result_img = imread(strcat('F:\ͼ�δ���\EESM5547\pgm\jpgTraining\',result,'.jpg'));
 
        
        axes( handles.axes7 ) %��ʾͼƬ��UI
        imshow(similar_1);
        axes( handles.axes8 )
        imshow(similar_2);
        axes( handles.axes9 )
        imshow(similar_3);
        axes( handles.axes10 )
        imshow(result_img);
        

%---------------------ѵ��������-----------------------
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global samplemean;
global base;
global allcoor;
global training_num;
%global training_path;

disp('Start training:......');
allsamples=[];%����ѵ��ͼ��   
%��ȡTrainingĿ¼
% if training_path == []
%     path = 'F:\ͼ�δ���\EESM5547\pgm\jpgTraining';
% else
%     path=training_path;
% end    
path = 'F:\ͼ�δ���\EESM5547\pgm\jpgTraining';
img_files = dir(path);
img_files(1:2)=[];
training_num = length(img_files);

for i=1:training_num
    a = imread(strcat('F:\ͼ�δ���\EESM5547\pgm\jpgTraining\',img_files(i).name));
    temp_img=imresize(a,[224 184]);  
    b = temp_img(1:224*184);   % b����ʸ�� 1��N������N��224*184����ȡ˳�������к��У������ϵ��£������� 
    b = double(b);
    allsamples = [ allsamples ; b];  % allsamples ��һ��M * N ����allsamples ��ÿһ�����ݴ���һ��ͼƬ������M��training_num
end


samplemean=mean(allsamples); % ƽ��ͼƬ��1 �� N    
figure%ƽ��ͼ  
imshow(mat2gray(reshape(samplemean,224,184)));  
for i=1:training_num  
    xmean(i,:)=allsamples(i,:)-samplemean; % xmean��һ��M �� N����xmeanÿһ�б���������ǡ�ÿ��ͼƬ����-ƽ��ͼƬ��   
end;     
% figure%ƽ��ͼ  
% imshow(mat2gray(reshape(xmean(1,:),112,92)));  
sigma=xmean*xmean';   % M * M �׾���   
[v,d]=eig(sigma);  
d1=diag(d);   
[d2,index]=sort(d1); %����������   
cols=size(v,2);% �����������������  size(v,1)��������
  
for i=1:cols        
    vsort(:,i) = v(:, index(cols-i+1) ); % vsort ��һ��M*col(ע:colһ�����M)�׾��󣬱�����ǰ��������е���������,ÿһ�й���һ����������        
    dsort(i)   = d1( index(cols-i+1) );  % dsort ������ǰ��������е�����ֵ����һά������   
end  %��ɽ������� %����ѡ��90%������   
dsum = sum(dsort);       
dsum_extract = 0;     
p = 0;       
while( dsum_extract/dsum < 0.9)         
    p = p + 1;            
    dsum_extract = sum(dsort(1:p));       
end  

a_1=1:1:training_num  
for i=1:1:training_num  
y(i)=sum(dsort(a_1(1:i)) );  
end  


figure  
y1=ones(training_num);  

axes( handles.axes16)
plot(a_1,y/dsum,a_1,y1*0.9,'linewidth',2);  
grid  
%title('ǰn��������ռ�ܵ������ٷֱ�');  
xlabel('Top n eigenvalues');  
ylabel('proportion');  

% plot(a_1,dsort/dsum,'linewidth',2);  
% grid  
% title('��n��������ռ�ܵ������ٷֱ�');  
% xlabel('��n������ֵ');  
% ylabel('ռ�ٷֱ�');  
% 


%------------------------------չʾ������------------------------------
i=1;  % (ѵ���׶�)�����������γɵ�����ϵ  
global num_eigenfaces;
global meanface_color;
global Itemp;


if num_eigenfaces == 0;
    num_eigenfaces=p;
end    
disp(['ѵ���е�num_eigenfaces: ',num2str(num_eigenfaces)]);

    
while ( i<= num_eigenfaces && dsort(i)>0 )        
    base(:,i) = dsort(i)^(1/2) * xmean' * vsort(:,i);   % base��N��p�׾��󣬳���dsort(i)^(1/2)�Ƕ�����ͼ��ı�׼����������  
      i = i + 1;   
end   % add by wolfsky �����������д��룬��ѵ������������ϵ�Ͻ���ͶӰ,�õ�һ�� M*p �׾���allcoor    

allcoor = allsamples * base; accu = 0;   % ���Թ��� 



%չʾǰ����������
A=reshape(base(:,1),[224 184]);   %ÿ��ͼƬ��СΪ112*92
A=mat2gray(A);
axes( handles.axes1 )
imshow(A);
B=reshape(base(:,2),[224 184]); 
B=mat2gray(B);
axes( handles.axes2 )
imshow(B)
C=reshape(base(:,3),[224 184]); 
C=mat2gray(C);
axes( handles.axes3 )
imshow(C)
D=reshape(base(:,4),[224 184]); 
D=mat2gray(D);
axes( handles.axes4 )
imshow(D)
E=reshape(base(:,5),[224 184]); 
E=mat2gray(E);
axes( handles.axes5 )
imshow(E)
E=reshape(base(:,6),[224 184]); 

averageFace =samplemean;   %ƽ������
F=reshape(averageFace,[224 184]); 
F=mat2gray(F);    %ֱ��ͼ���⻯
J72=histeq(F,72);
Itemp=J72;
axes( handles.axes11)
imshow(J72);
save
msgbox('Training Over')



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%------------------����������������-------------------
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global num_eigenfaces;
num_eigenfaces=str2num(get(handles.edit4,'String'));
disp(['������num_eigenface: ',num2str(num_eigenfaces)]);


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    
end



%-------------------ʶ���ʲ���-----------------
%���select testing file and start��ť��ֱ��ѡ���Ӧ�ļ�����ͼƬ����Ŀ¼��
%ע��ҪѡͼƬ��������ȡ�����ڵ�Ŀ¼��Ȼ�����Ŀ¼����������Ƭ��
% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global base;
global allcoor;
global training_num;

disp('Start accuracy testing:......');

[filename, path] = uigetfile({'*.jpg'},'choose photo');


img_files = dir(path);
img_files(1:2) = []; %ȥ������Ŀ¼��
training_num_2 = length(img_files);
 accu=0;
for i=1:training_num_2
        a = imread(strcat(path,'\',img_files(i).name));
        
        temp_img_2=imresize(a,[224 184]);
        b = temp_img_2(1:224*184);      
        b=double(b);          
        tcoor= b * base; %�������꣬��1��p�׾���        
        for k=1:training_num                   
            mdist(k)=norm(tcoor-allcoor(k,:));          
        end;          
        %Third order recognition    
        [dist,index2]=sort(mdist);            
        class1=floor( index2(1)/10 )+1;        
        class2=floor(index2(2)/10)+1;          
        class3=floor(index2(3)/10)+1;          
        if class1~=class2 && class2~=class3   
            class=class1;           
        elseif class1==class2            
            class=class1;           
        elseif class2==class3       
            class=class2;           
        end;    
        if class== floor((i-1)/5)+1        
            accu=accu+1;          
        end;       
end;    
accuracy=accu/training_num_2; %���ʶ����
out = 100*accuracy;
str_out=strcat(num2str(out),'%');
set(handles.edit5,'String',str_out);

%�����ǽ����е��change��ť������������ɫ������Ƭ���룬���Ų�ɫ����ͼƬ��ʹ��
%gay2jpg��file1,file2���������ɣ����Խ��ú������ڽ��룬���ǲ�ɫ�����̺ܺ�ʱ��
%���������ֱ�ӽ����ɺõĲ�ɫ����Ƭ�����滻��

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Itemp;

I=imread('jpgƽ����1_72_color.jpg'); %���ڲ�ɫ��ƽ��������Ƭ���滻ԭ����ƽ��������Ƭ��
img_color = imresize(I,[224 184]);
axes( handles.axes11)
imshow(img_color);


%������Ÿı�%
function [ output ] = fileNum( input)
%�ı���ź��ļ����Ķ�Ӧ��
%   �˴���ʾ��ϸ˵��
if input<10
    output=strcat('00',num2str(input));
elseif input<100
    output=strcat('0',num2str(input));
else
    output = num2str(input);

  end
